//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Files
import Foundation
import UIKit.UIImage

public final class FileProvider {

    var rootFolder: Folder?

    init(_ rootFolderName: String) {
        rootFolder = try? Folder.documents?.createSubfolderIfNeeded(withName: rootFolderName)
    }

    func listConfigurationFiles() -> AnyPublisher<[ConfigurationFile], FileProviderError> {
        guard let folder = rootFolder else {
            return Just([]).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
        }
        return Just(folder.files.compactMap { file in
            return ConfigurationFile(
                path: file.path,
                name: file.name,
                nameExcludingExtension: file.nameExcludingExtension
            )
        }).setFailureType(to: FileProviderError.self).eraseToAnyPublisher()
    }

    func save<T: Encodable>(_ object: T, fileName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let data = try? JSONEncoder().encode(object) else {
            return Fail(error: FileProviderError.stringConversionFailure).eraseToAnyPublisher()
        }

        guard let folder = rootFolder else {
            return Fail(error: FileProviderError.fileSystemFailure).eraseToAnyPublisher()
        }

        return save(data: data, in: folder, with: fileName)
    }

    func saveImage(_ image: UIImage, fileName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let data = image.pngData() else {
            return Fail(error: FileProviderError.stringConversionFailure).eraseToAnyPublisher()
        }

        guard let folder = rootFolder else {
            return Fail(error: FileProviderError.fileSystemFailure).eraseToAnyPublisher()
        }

        return save(data: data, in: folder, with: fileName)
    }

    private func save(data: Data, in folder: Folder, with fileName: String) -> AnyPublisher<Void, FileProviderError> {
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

    func read<T: Codable>(_ fileName: String) -> T? {
        guard let file = file(for: fileName) else {
            return nil
        }
        return read(filePath: file.path)
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

    func delete(_ fileName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let file = file(for: fileName) else {
            return Fail(error: FileProviderError.fileSystemFailure).eraseToAnyPublisher()
        }
        return delete(filePath: file.path)
    }

    private func file(for fileName: String) -> File? {
        guard let folder = rootFolder else {
            return nil
        }

        return try? folder.file(named: fileName)
    }
}

struct ConfigurationFile: Hashable, Codable {
    let path: String
    let name: String
    let nameExcludingExtension: String
}

public enum FileProviderError: Error {
    case stringConversionFailure
    case fileSystemFailure
    case savingFailure(underlyingError: Error)
    case deletingFailure(underlyingError: Error)
}
