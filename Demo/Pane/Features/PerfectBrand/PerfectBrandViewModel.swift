//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import SwiftUI

final class PerfectBrandViewModel: ObservableObject {
    enum State {
        case intializing
        case loading
        case empty
        case hasData(Image)
        case error(Error)
    }

    enum Constants {
        static let aspectRatioOptions = ["No", "Fit", "Fill"]
    }

    @Published private(set) var state: State = .intializing

    @Published var configuration: Configuration = .default

    @Published var selectedSourceIndex = 0
    @Published var imageURLString: String = ""

    let fileProvider = FileProvider("configurations")
    private var cancellables = Set<AnyCancellable>()

    init() {
        $selectedSourceIndex
            .sink { [weak self] value in
                if value == 0 {
                    let image = Image("sample")
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
            .map { Image(uiImage: $0) }
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
        state = .hasData(Image(uiImage: image))
    }

    func saveConfiguration() {
        let filename = configuration.suggestedFilename
        fileProvider.save(configuration, fileName: filename)
            .sink (
                receiveCompletion:
                    { [weak self] result in
                        switch result {
                        case .finished:
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    },
                receiveValue: { [weak self] in
                    print("Configuration saved successfully")
                }
            )
            .store(in: &cancellables)
    }

    func loadConfiguration() {

    }
}

private extension Configuration {
    var suggestedFilename: String {
        "\(description).json"
    }
}
