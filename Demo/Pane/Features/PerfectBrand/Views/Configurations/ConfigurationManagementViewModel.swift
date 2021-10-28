//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Foundation
import NotificationBannerSwift

extension ConfigurationManagementView {
    final class ViewModel: ObservableObject {
        @Published var folders: [ConfigurationFolder] = []
        @Published var message: NotificationBanner?

        private let fileProvider: FileProvider

        private var bag = Set<AnyCancellable>()

        init(fileProvider: FileProvider) {
            self.fileProvider = fileProvider
        }

        func fetchConfigurationFiles() {
            fileProvider.listConfigurationFolders().sink { [weak self] result in
                switch result {
                case .failure:
                    self?.message = NotificationBanner(
                        title: "Error!",
                        subtitle: "Failed to fetch configurations",
                        style: .danger
                    )
                default: break
                }
            } receiveValue: { folders in
                self.folders = folders
            }
            .store(in: &bag)

        }

        func configuration(from folder: ConfigurationFolder) -> SelectedConfiguration? {
            guard let folder = try? fileProvider.rootFolder?.subfolder(named: folder.name) else {
                return nil
            }

            guard let configuration: Configuration = fileProvider.read("configuration.json", in: folder) else {
                return nil
            }
            let image = fileProvider.readImage(in: folder)

            return SelectedConfiguration(
                name: folder.name,
                configuration: configuration,
                image: image
            )
        }

        func removeFiles(at indexSet: IndexSet) {
            let folder = folders[indexSet.first!]
            fileProvider.deleteFolder(folder.name).sink { [weak self] result in
                switch result {
                case .failure:
                    self?.message = NotificationBanner(
                        title: "Error!",
                        subtitle: "Failed to fetch configurations",
                        style: .danger
                    )
                case .finished:
                    self?.folders.remove(at: indexSet.first!)
                }

            } receiveValue: { _ in }
                .store(in: &bag)
        }
    }
}
