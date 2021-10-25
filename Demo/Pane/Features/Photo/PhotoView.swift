//
// Copyright © 2021 An Tran. All rights reserved.
//

import AnPhotosPicker
import BottomSheet
import SwiftUI
import TweakPane

public struct PhotoView: View {

    // ViewModel
    @StateObject private var viewModel = PhotoViewModel()

    // BottomSheet
    @State private var isSheetExpanded = true

    @State private var isPresentingImagePicker = false

    public init() {}

    public var body: some View {
        VStack {
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
                image
                    .if(viewModel.resizingMode != nil) {
                        $0.resizable(resizingMode: viewModel.resizingMode!)
                    }
                    .if(viewModel.aspectRatio != nil) {
                        $0.aspectRatio(contentMode: viewModel.aspectRatio!)
                    }
                    .rotationEffect(.degrees(viewModel.rotationAngle))
                    .rotation3DEffect(.degrees(viewModel.rotationX), axis: (x: 1, y: 0, z: 0))
                    .rotation3DEffect(.degrees(viewModel.rotationY), axis: (x: 0, y: 1, z: 0))
                    .rotation3DEffect(.degrees(viewModel.rotationZ), axis: (x: 0, y: 0, z: 1), anchorZ: 0.5)
                    .frame(width: 300, height: 300)
                    .border(viewModel.borderColor, width: viewModel.borderWidth)
                    .if(viewModel.clipped) {
                        $0.clipped()
                    }
                    .padding(.top)
            }

            if isSheetExpanded {
                Spacer()
            }
        }
        .animation(.easeOut)
        .bottomSheet(sheet)
        .sheet(isPresented: $isPresentingImagePicker) {
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

    var sheet: some BottomSheetView {
        BottomSheet(
            isExpanded: $isSheetExpanded,
            minHeight: .points(120),
            maxHeight: .percentage(0.5)
        ) {
            ScrollView {
                Pane([
                    InputBlade(
                        name: "Resizing",
                        option: .options(PhotoViewModel.Constants.resizingOptions, style: .segmented),
                        binding: InputBinding($viewModel.selectedResizingOption)
                    ),
                    
                    InputBlade(
                        name: "Aspect Ratio",
                        option: .options(PhotoViewModel.Constants.aspectRatioOptions, style: .segmented),
                        binding: InputBinding($viewModel.selectedAspectRatioOption)
                    ),
                    
                    InputBlade(
                        name: "Clipped",
                        binding: InputBinding($viewModel.clipped)
                    ),
                    
                    InputBlade(
                        name: "Border Color",
                        binding: InputBinding($viewModel.borderColor)
                    ),
                    
                    InputBlade(
                        name: "Border Width",
                        option: .stepperDouble(range: 2 ... 10),
                        binding: InputBinding($viewModel.borderWidth)
                    ),
                    
                    InputBlade(
                        name: "Rotation",
                        option: .slider(range: -180 ... 180),
                        binding: InputBinding($viewModel.rotationAngle)
                    ),
                    FolderBlade(
                        "3D",
                        blades: [
                            InputBlade(
                                name: "Rotation X",
                                option: .slider(range: -180 ... 180),
                                binding: InputBinding($viewModel.rotationX)
                            ),
                            
                            InputBlade(
                                name: "Rotation Y",
                                option: .slider(range: -180 ... 180),
                                binding: InputBinding($viewModel.rotationY)
                            ),
                            
                            InputBlade(
                                name: "Rotation Z",
                                option: .slider(range: -180 ... 180),
                                binding: InputBinding($viewModel.rotationZ)
                            ),
                        ]
                    ),
                ])
                    .padding(.horizontal)
                    .padding(.bottom, 100)
            }
        }
    }
}
