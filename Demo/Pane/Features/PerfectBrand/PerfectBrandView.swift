//
// Copyright © 2021 An Tran. All rights reserved.
//

import AnPhotosPicker
import SwiftUI
import TweakPane
import PagerTabStripView

public struct PerfectBrandView: View {

    // ViewModel
    @StateObject private var viewModel = PerfectBrandViewModel()

    @State private var isPresentingImagePicker = false

    public init() {}

    public var body: some View {
        NavigationView {
            switch viewModel.state {
            case .intializing:
                EmptyView()
            case .loading:
                Text("Loading ...")
            case .empty:
                Image("placeholder")
            case .error(let error):
                Text(error.localizedDescription)
            case .hasData(let image):
                ZStack {
                    Rectangle()
                        .fill(Color.black)

                    VStack(spacing: 0) {
                        canvasView(image)

                        Spacer()

                        PagerTabStripView() {
                            colorPane
                                .pagerTabItem {
                                    TitleNavBarItem(title: "Color")
                                }
                            perspectivePane
                                .pagerTabItem {
                                    TitleNavBarItem(title: "Perspective")
                                }
                            backgroundPane
                                .pagerTabItem {
                                    TitleNavBarItem(title: "Background")
                                }

                        }
                        .background(Color.white)
                        .padding(.bottom, 20)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(
                            action: {
                                print("Share")
                            },
                            label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        )
                        Button(
                            action: {
                                print("Load")
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                }
            }

        }.sheet(isPresented: $isPresentingImagePicker) {
            AnPhotosPicker(
                filter: .images,
                selectionLimit: 1,
                completionHandler: { (images: [SelectedImage]) in
                    isPresentingImagePicker = false
                    guard let selectedImage = images.first else { return }
                    viewModel.select(selectedImage.image)
                }
            )
        }
        .navigationBarTitle("", displayMode: .inline)
    }

    private func canvasView(_ image: Image) -> some View {
        GeometryReader { proxy in
            ZStack {
                CanvasView(
                    image: image,
                    configuration: viewModel.configuration
                )
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height
                )
                .clipped()
            }
        }
    }

    private var colorPane: some View {
        ScrollView {
            Pane([
                InputBlade(
                    name: "Inset Padding",
                    option: .slider(range: 0...100),
                    binding: InputBinding($viewModel.configuration.padding)
                ),

                InputBlade(
                    name: "Border Radius",
                    option: .slider(range: 0...20),
                    binding: InputBinding($viewModel.configuration.border.radius)
                ),

                InputBlade(
                    name: "Border Width",
                    option: .slider(range: 0...20),
                    binding: InputBinding($viewModel.configuration.border.width)
                ),

                InputBlade(
                    name: "Border Color",
                    binding: InputBinding($viewModel.configuration.border.color)
                ),
            ])
                .padding(20)
        }
    }

    private var perspectivePane: some View {
        ScrollView {
            Pane([
                InputBlade(
                    name: "Rotation X",
                    option: .slider(range: -180 ... 180),
                    binding: InputBinding($viewModel.configuration.perspective.rotationX)
                ),

                InputBlade(
                    name: "Rotation Y",
                    option: .slider(range: -180 ... 180),
                    binding: InputBinding($viewModel.configuration.perspective.rotationY)
                ),

                InputBlade(
                    name: "Rotation Z",
                    option: .slider(range: -180 ... 180),
                    binding: InputBinding($viewModel.configuration.perspective.rotationZ)
                ),
            ])
                .padding(20)
        }
    }

    @ViewBuilder
    private var backgroundPane: some View {
        ScrollView {
            switch viewModel.configuration.background.style {
            case .solid(let color):
                Pane([
                    InputBlade(
                        name: "Color",
                        binding: InputBinding(
                            Binding(
                                get: {
                                    color
                                },
                                set: { newValue in
                                    viewModel.configuration.background.style = .solid(color: newValue)
                                }
                        ))
                    ),
                ])
                .padding(20)
            case .pattern(pattern: let pattern):
                EmptyView()
            }
        }
    }
}

struct TitleNavBarItem: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(Color.gray)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
