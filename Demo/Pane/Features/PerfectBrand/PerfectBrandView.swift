//
// Copyright © 2021 An Tran. All rights reserved.
//

import AnPhotosPicker
import PagerTabStripView
import SwiftUI
import TweakPane

public struct PerfectBrandView: View {


    @StateObject private var viewModel = PerfectBrandViewModel()

    public init() {}

    public var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                Text("Loading ...")
                    .onAppear {
                        viewModel.loadImage()
                    }
            case .empty:
                Image("placeholder")
            case .error(let error):
                Text(error.localizedDescription)
            case .hasData(let image):
                ZStack {
                    Rectangle()
                        .fill(Color.black)

                    VStack(spacing: 0) {
                        canvasView(Image(uiImage: image))

                        PagerTabStripView {
                            borderPane
                                .pagerTabItem {
                                    TitleNavBarItem(symbol: "rectangle.inset.filled")
                                }
                            perspectivePane
                                .pagerTabItem {
                                    TitleNavBarItem(symbol: "perspective")
                                }
                            backgroundPane
                                .pagerTabItem {
                                    TitleNavBarItem(symbol: "eyedropper")
                                }
                            watermarkPane
                                .pagerTabItem {
                                    TitleNavBarItem(symbol: "checkmark.rectangle.fill")
                                }
                        }
                        .background(Color.white)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(
                            action: {
                                viewModel.isShowingConfirmingNewPhoto.toggle()
                            },
                            label: {
                                Image(systemName: "doc")
                            }
                        )

                        Menu {
                            Button(
                                action: {
                                    viewModel.saveConfiguration()
                                },
                                label: {
                                    Label("Save preset", image: "square.and.arrow.up")
                                }
                            )
                            Button(
                                action: {
                                    viewModel.sheetView = .configurations(id: UUID().uuidString)
                                },
                                label: {
                                    Label("Load preset", image: "square.and.arrow.up")
                                }
                            )
                        } label: {
                            Image(systemName: "doc.richtext")
                        }
                        
                        Button(
                            action: {
                                viewModel.sheetView = .photosPicker(id: UUID().uuidString)
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                }
            }
        }
        .actionSheet(isPresented: $viewModel.isShowingConfirmingNewPhoto, content: {
            ActionSheet(
                title: Text("Confirmation"),
                message: Text("Your current unsaved changes will be lost!\nDo you want to continue?"),
                buttons: [
                    Alert.Button.default(Text("Yes")) {
                        viewModel.genereateNewConfiguration()
                    },
                    .cancel(),
                ]
            )
        })
        .sheet(
            item: $viewModel.sheetView,
            onDismiss: {
                viewModel.sheetView = nil
            },
            content: { item in
                switch item {
                case .photosPicker:
                    AnPhotosPicker(
                        filter: .images,
                        selectionLimit: 1,
                        completionHandler: { (images: [SelectedImage]) in
                            viewModel.sheetView = nil
                            guard let selectedImage = images.first else { return }
                            viewModel.select(selectedImage.image)
                        }
                    )
                case .configurations:
                    ConfigurationManagementView(
                        fileProvider: viewModel.fileProvider,
                        configuration: $viewModel.selectedConfiguration
                    )

                case .enterFolderName(_, let image, let configuration):
                    PreviewView(
                        folderName: "",
                        image: image,
                        configuration: configuration
                    ) {
                        viewModel.saveConfiguration(in: $0)
                    }
                }

            }
        )
        .onReceive(viewModel.$message) { banner in
            banner?.show()
        }
        .navigationBarTitle("", displayMode: .inline)
    }

    @ViewBuilder
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

    @ViewBuilder
    private var borderPane: some View {
        ScrollView {
            Pane([
                InputBlade(
                    name: "Inset Padding",
                    option: .slider(range: 0 ... 100),
                    binding: InputBinding($viewModel.configuration.padding)
                ),
                
                InputBlade(
                    name: "Border Radius",
                    option: .slider(range: 0 ... 20),
                    binding: InputBinding($viewModel.configuration.border.radius)
                ),
                
                InputBlade(
                    name: "Border Width",
                    option: .slider(range: 0 ... 20),
                    binding: InputBinding($viewModel.configuration.border.width)
                ),
                
                InputBlade(
                    name: "Border Color",
                    binding: InputBinding($viewModel.configuration.border.color)
                ),
            ])
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }

    @ViewBuilder
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
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }

    @ViewBuilder
    private var backgroundPane: some View {
        ScrollView {
            Pane([
                InputBlade(
                    name: "Background",
                    option: .optionsCustomViews(
                        count: Background.Style.allCases.count,
                        viewBuilder: { index in
                            switch index {
                            case 0:
                                return AnyView(
                                    Rectangle()
                                        .fill(viewModel.configuration.background.color)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(13)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 13)
                                                .stroke(Color.gray, lineWidth: 2)
                                        )
                                )
                            case 1:
                                return AnyView(
                                    SquarePatternView(
                                        size: 5,
                                        color: viewModel.configuration.background.color
                                    )
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(13)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 13)
                                                .stroke(Color.gray, lineWidth: 2)
                                        )
                                )
                            default:
                                assertionFailure("invalid index")
                                return AnyView(EmptyView())
                            }
                        }
                    ),
                    binding: InputBinding(Binding<Int>(
                        get: {
                            switch viewModel.configuration.background.style {
                            case .solid:
                                return 0
                            case .square:
                                return 1
                            }
                        },
                        set: { newValue in
                            switch newValue {
                            case 0:
                                viewModel.configuration.background.style = .solid
                            case 1:
                                let size = viewModel.configuration.background.size
                                viewModel.configuration.background = Background(
                                    style: .square,
                                    color: viewModel.configuration.background.color,
                                    size: size == 0 ? 40 : size
                                )
                            default:
                                assertionFailure("invalid index")
                            }
                        }
                    ))
                ),
                InputBlade(
                    name: "Size",
                    option: .slider(range: 10 ... 100),
                    binding: InputBinding($viewModel.configuration.background.size)
                ),
            ])
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }

    @ViewBuilder
    private var watermarkPane: some View {
        ScrollView {
            Pane([
                InputBlade(
                    name: "Text",
                    binding: InputBinding($viewModel.configuration.watermark.text)
                ),
                InputBlade(
                    name: "Position",
                    option: .optionsImage([
                        Image(systemName: "rectangle.inset.topleft.filled"),
                        Image(systemName: "rectangle.inset.topright.filled"),
                        Image(systemName: "rectangle.inset.bottomright.filled"),
                        Image(systemName: "rectangle.inset.bottomleft.filled"),
                    ]),
                    binding: InputBinding(Binding<Int>(
                        get: {
                            switch viewModel.configuration.watermark.position {
                            case .topLeft:
                                return 0
                            case .topRight:
                                return 1
                            case .bottomRight:
                                return 2
                            case .bottomLeft:
                                return 3
                            }
                        },
                        set: { newValue in
                            switch newValue {
                            case 0:
                                viewModel.configuration.watermark.position = .topLeft
                            case 1:
                                viewModel.configuration.watermark.position = .topRight
                            case 2:
                                viewModel.configuration.watermark.position = .bottomRight
                            case 3:
                                viewModel.configuration.watermark.position = .bottomLeft
                            default:
                                assertionFailure("invalid index")
                            }
                        }
                    ))
                ),
            ])
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
        }
    }
}

struct TitleNavBarItem: View {
    let symbol: String

    var body: some View {
        VStack {
            Image(systemName: symbol)
                .foregroundColor(Color.gray)
                .imageScale(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
