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
        static let aspectRatioOptions = ["No", "Fit", "Fill"]
    }

    @Published private(set) var state: State = .intializing

    @Published var selectedResizingOption = "No"
    @Published var resizingMode: Image.ResizingMode? = nil

    @Published var selectedAspectRatioOption = "Fit"
    @Published var aspectRatio: ContentMode? = nil

    @Published var clipped: Bool = false

    @Published var borderColor: Color = .red

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

        $selectedAspectRatioOption
            .sink { [weak self] value in
                self?.updateAspectRatio(with: value)
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

    private func updateAspectRatio(with option: String) {
        if option == "Fit" {
            aspectRatio = .fit
        } else if option == "Fill" {
            aspectRatio = .fill
        } else {
            aspectRatio = nil
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
