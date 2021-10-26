//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Files
import Foundation

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

    func save<T: Codable>(_ object: T, fileName: String) -> AnyPublisher<Void, FileProviderError> {
        guard let string = object.prettyPrintedJSONString, let data = string.data(using: .utf8) else {
            return Fail(error: FileProviderError.stringConversionFailure).eraseToAnyPublisher()
        }

        guard let folder = rootFolder else {
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

    private func read<T: Codable>(filePath: String) -> T? {
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
