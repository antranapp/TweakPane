//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import SwiftUI
import NotificationBannerSwift
import UIKit.UIImage

final class PerfectBrandViewModel: ObservableObject {
    enum State {
        case intializing
        case loading
        case empty
        case hasData(UIImage)
        case error(Error)
    }

    enum Sheet: Identifiable {
        var id: String {
            switch self {
            case .photosPicker(let id):
                return id
            case .configurations(let id):
                return id
            case .enterFolderName(let id, _ , _):
                return id
            }
        }

        case photosPicker(id: String)
        case configurations(id: String)
        case enterFolderName(id: String, image: UIImage, configuration: Configuration)
    }

    enum Constants {
        static let aspectRatioOptions = ["No", "Fit", "Fill"]
    }

    @Published private(set) var state: State = .intializing

    @Published var configuration: Configuration = .default

    @Published var selectedSourceIndex = 0
    @Published var imageURLString: String = ""
    @Published var message: NotificationBanner?

    @Published var selectedConfiguration: SelectedConfiguration? {
        didSet {
            if let selectedConfiguration = selectedConfiguration {
                configuration = selectedConfiguration.configuration
                let image = selectedConfiguration.image ?? UIImage(named: "sample")!
                state = .hasData(image)
            }
        }
    }

    @Published var sheetView: Sheet? = nil
    @Published var isShowingConfirmingNewPhoto: Bool = false

    let fileProvider = FileProvider("configurations")
    private var cancellables = Set<AnyCancellable>()

    init() {
        $selectedSourceIndex
            .sink { [weak self] value in
                if value == 0 {
                    let image = UIImage(named: "sample")!
                    self?.state = .hasData(image)
                }
            }
            .store(in: &cancellables)
    }

    func loadRemoteImage() {
        guard let url = URL(string: imageURLString) else { return }
        state = .loading
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure(let error):
                        self?.state = .error(error)
                    case .finished: break
                    }
                },
                receiveValue: { [weak self] image in
                    self?.state = .hasData(image)
                }
            )
            .store(in: &cancellables)
    }

    func select(_ image: UIImage) {
        state = .hasData(image)
    }

    func saveConfiguration() {
        guard case let .hasData(image) = state else { return }

        guard let selectedConfiguration = selectedConfiguration else {
            sheetView = .enterFolderName(id: UUID().uuidString, image: image, configuration: configuration)
            return
        }

        saveConfiguration(in: selectedConfiguration.name)
    }

    func saveConfiguration(in folderName: String) {
        guard case let .hasData(image) = state else { return }

        fileProvider
            .save(configuration: configuration, image: image, in: folderName)
            .receive(on: DispatchQueue.main)
            .sink (
                receiveCompletion:
                    { [weak self] result in
                        switch result {
                        case .finished:
                            break
                        case .failure(let error):
                            self?.message = NotificationBanner(
                                title: "Error!",
                                subtitle: error.localizedDescription,
                                style: .success
                            )
                        }
                    },
                receiveValue: { [weak self] in
                    self?.message = NotificationBanner(
                        title: "Suceed!",
                        subtitle: "Configuration saved successfully",
                        style: .success
                    )
                }
            )
            .store(in: &cancellables)
    }

    func genereateNewConfiguration() {
        configuration = .default
        state = .hasData(UIImage(named: "sample")!)
    }


}

struct SelectedConfiguration {
    let name: String
    let configuration: Configuration
    let image: UIImage?
}
