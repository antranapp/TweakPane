//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Foundation
import NotificationBannerSwift

extension ConfigurationManagementView {
    final class ViewModel: ObservableObject {
        @Published var files: [ConfigurationFile] = []
        @Published var message: NotificationBanner?

        private let fileProvider: FileProvider

        private var bag = Set<AnyCancellable>()

        init(fileProvider: FileProvider) {
            self.fileProvider = fileProvider
        }

        func fetchConfigurationFiles() {
            fileProvider.listConfigurationFiles().sink { [weak self] result in
                switch result {
                case .failure:
                    self?.message = NotificationBanner(
                        title: "Error!",
                        subtitle: "Failed to fetch configurations",
                        style: .danger
                    )
                default: break
                }
            } receiveValue: { files in
                self.files = files
            }
            .store(in: &bag)

        }

        func configuration(from file: ConfigurationFile) -> Configuration? {
            fileProvider.read(file.name)
        }

        func removeFiles(at indexSet: IndexSet) {
            let file = files[indexSet.first!]
            fileProvider.delete(file.name).sink { [weak self] result in
                switch result {
                case .failure:
                    self?.message = NotificationBanner(
                        title: "Error!",
                        subtitle: "Failed to fetch configurations",
                        style: .danger
                    )
                case .finished:
                    self?.files.remove(at: indexSet.first!)
                }

            } receiveValue: { _ in }
                .store(in: &bag)
        }
    }
}
