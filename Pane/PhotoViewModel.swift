//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import SwiftUI

final class PhotoViewModel: ObservableObject {
    enum State {
        case intializing
        case loading
        case empty
        case hasData(Image)
        case error(Error)
    }

    enum Constants {
        static let resizingOptions = ["No", "Stretch", "Tile"]
    }

    @Published private(set) var state: State = .intializing

    @Published var selectedResizingOption = "No"
    @Published var resizingMode: Image.ResizingMode? = nil

    @Published var selectedAspectRatioIndex = 2
    @Published var aspectRatio: ContentMode? = nil

    @Published var selectedClippedIndex = 1
    @Published var clipped: Bool = false

    @Published var selectedSourceIndex = 0
    @Published var imageURLString: String = ""
    @Published var isLoading: Bool = false

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

        $selectedResizingOption
            .sink { [weak self] value in
                self?.updateResizable(with: value)
            }
            .store(in: &cancellables)

        $selectedAspectRatioIndex
            .sink { [weak self] value in
                self?.updateAspectRatio(with: value)
            }
            .store(in: &cancellables)

        $selectedClippedIndex
            .sink { [weak self] value in
                self?.updateClippingMode(with: value)
            }
            .store(in: &cancellables)
    }

    private func updateResizable(with option: String) {
        if option == "Stretch" {
            resizingMode = .stretch
        } else if option == "Tile" {
            resizingMode = .tile
        } else {
            resizingMode = nil
        }
    }

    private func updateAspectRatio(with index: Int) {
        if index == 1 {
            aspectRatio = .fit
        } else if index == 2 {
            aspectRatio = .fill
        } else {
            aspectRatio = nil
        }
    }

    private func updateClippingMode(with index: Int) {
        if index == 0 {
            clipped = false
        } else if index == 1 {
            clipped = true
        }
    }

    func loadRemoteImage() {
        guard let url = URL(string: imageURLString) else { return }
        isLoading = true
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
                    self?.isLoading = false
                    self?.state = .hasData(image)
                }
            )
            .store(in: &cancellables)
    }

    func select(_ image: UIImage) {
        state = .hasData(Image(uiImage: image))
    }
}
