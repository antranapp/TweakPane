//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import SwiftUI
import NotificationBannerSwift

final class PerfectBrandViewModel: ObservableObject {
    enum State {
        case intializing
        case loading
        case empty
        case hasData(UIImage)
        case error(Error)
    }

    enum Constants {
        static let aspectRatioOptions = ["No", "Fit", "Fill"]
    }

    @Published private(set) var state: State = .intializing

    @Published var configuration: Configuration = .default

    @Published var selectedSourceIndex = 0
    @Published var imageURLString: String = ""
    @Published var message: NotificationBanner?

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

        let filename = configuration.suggestedFilename
        let imageFilename = "image.png"

        fileProvider
            .save(configuration, fileName: filename)
            .flatMap { self.fileProvider.saveImage(image, fileName: imageFilename) }
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

}

private extension Configuration {
    var suggestedFilename: String {
        "\(description).json"
    }
}
