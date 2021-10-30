//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Files
import Foundation
import UIKit.UIImage

public final class FileProvider {

    public let rootFolder: Folder?

    init(_ rootFolderName: String) {
        rootFolder = try? Folder.documents?.createSubfolderIfNeeded(withName: rootFolderName)
    }

    func listConfigurationFolders() -> AnyPublisher<[ConfigurationFolder], FileProviderError> {
        guard let folder = rootFolder else {
            return Just([]).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        }
        return Just(folder.subfolders.compactMap { folder in
            return ConfigurationFolder(
                name: folder.name,
                createdAt: folder.creationDate
            )
        }).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
    }

    func listConfigurationFiles(in folder: ConfigurationFolder) -> AnyPublisher<[ConfigurationFile], FileProviderError> {
        guard let folder = rootFolder else {
            return Just([]).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        }

        guard let configurationFolder = try? folder.subfolder(named: folder.name) else {
            return Just([]).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        }

        return Just(configurationFolder.files.filter{ $0.extension == ".json" }.compactMap { file in
            return ConfigurationFile(
                path: file.path,
                name: file.name,
                nameExcludingExtension: file.nameExcludingExtension
            )
        }).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
    }

    func save(configuration: Configuration, image: UIImage, in folderName: String) -> AnyPublisher<Void, FileProviderError> {

        // Best effort to delete the current folder
        let folder = try? rootFolder?.subfolder(named: folderName)
        try? folder?.delete()

        return save(configuration, in: folderName, with: "configuration.json")
                .flatMap { self.saveImage(image, in: folderName, with: "image.png") }
                .eraseToAnyPublisher()
    }

    func save<T: Encodable>(_ object: T, in folderName: String, with fileName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let data = try? JSONEncoder().encode(object) else {
            return Fail(error: FileProviderError.stringConversionFailure).eraseToAnyPublisher()
        }

        return save(data: data, in: folderName, with: fileName)
    }

    private func saveImage(_ image: UIImage, in folderName: String, with fileName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let data = image.pngData() else {
            return Fail(error: FileProviderError.stringConversionFailure).eraseToAnyPublisher()
        }

        return save(data: data, in: folderName, with: fileName)
    }

    private func save(data: Data, in folderName: String, with fileName: String) -> AnyPublisher<Void, FileProviderError> {

        var folderOrNil: Folder?
        if rootFolder?.containsSubfolder(named: folderName) == false {
            folderOrNil = try? rootFolder?.createSubfolder(named: folderName)
        } else {
            folderOrNil = try? rootFolder?.subfolder(named: folderName)
        }

        guard let folder = folderOrNil else  {
            return Fail(error: FileProviderError.fileSystemFailure).eraseToAnyPublisher()
        }

        do {
            let file = try folder.createFile(named: fileName)
            try file.write(data)
            return Just(()).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: FileProviderError.savingFailure(underlyingError: error)).eraseToAnyPublisher()
        }
    }

    private func read<T: Decodable>(filePath: String) -> T? {
        do {
            let file = try File(path: filePath)
            let data = try file.read()
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }

    func readFolder<T: Decodable>(_ folderName: String) -> (T?, UIImage?) {
        guard let folder = try? rootFolder?.subfolder(named: folderName) else {
            return (nil, nil)
        }

        let configuration: T? = read("configuration.json", in: folder)
        let image = readImage(in: folder)

        return (configuration, image)
    }

    func read<T: Decodable>(_ fileName: String, in folder: Folder) -> T? {
        guard let file = file(for: fileName, in: folder) else {
            return nil
        }
        return read(filePath: file.path)
    }

    func readImage(in folder: Folder) -> UIImage? {
        do {
            let file = try folder.file(named: "image.png")
            let data = try file.read()
            return UIImage(data: data)
        } catch {
            return nil
        }
    }

    private func delete(filePath: String) -> AnyPublisher<Void, FileProviderError> {
        do {
            let file = try File(path: filePath)
            try file.delete()
            return Just(()).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: FileProviderError.deletingFailure(underlyingError: error)).eraseToAnyPublisher()
        }
    }

    func deleteFolder(_ folderName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let folder = try? rootFolder?.subfolder(named: folderName) else {
            return Just(()).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        }

        do {
            try folder.delete()
            return Just(()).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: FileProviderError.deletingFailure(underlyingError: error)).eraseToAnyPublisher()
        }
    }

    func delete(_ fileName: String, in folder: String) -> AnyPublisher<Void, FileProviderError> {
        guard let file = file(for: fileName, in: folder) else {
            return Fail(error: FileProviderError.fileSystemFailure).eraseToAnyPublisher()
        }
        return delete(filePath: file.path)
    }

    private func file(for fileName: String, in folder: String) -> File? {
        guard let folder = try? rootFolder?.subfolder(named: folder) else {
            return nil
        }

        return file(for: fileName, in: folder)
    }

    private func file(for fileName: String, in folder: Folder) -> File? {
        return try? folder.file(named: fileName)
    }
}

struct ConfigurationFile: Hashable, Codable {
    let path: String
    let name: String
    let nameExcludingExtension: String
}

struct ConfigurationFolder: Hashable, Codable {
    let name: String
    let createdAt: Date?
}

public enum FileProviderError: Error {
    case stringConversionFailure
    case fileSystemFailure
    case savingFailure(underlyingError: Error)
    case deletingFailure(underlyingError: Error)
}
