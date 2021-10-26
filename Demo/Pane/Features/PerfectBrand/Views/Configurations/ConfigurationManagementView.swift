//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import NotificationBannerSwift

struct ConfigurationManagementView: View {
    @Environment(\.presentationMode) private var presentationMode

    @StateObject private var viewModel: ViewModel

    @Binding var configuration: Configuration

    init(
        fileProvider: FileProvider,
        configuration: Binding<Configuration>
    ) {
        _viewModel = StateObject(wrappedValue: ViewModel(fileProvider: fileProvider))
        _configuration = configuration
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.files, id: \.self) { file in
                    HStack {
                        Button(action: {
                            if let selectedConfiguration = viewModel.configuration(from: file) {
                                configuration = selectedConfiguration
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                print("Failed to parse configuration")
                            }
                        }) {
                            Text(file.name)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .onDelete(perform: viewModel.removeFiles)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Configurations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()

                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                        }
                    )
                }
            }
            .onAppear {
                viewModel.fetchConfigurationFiles()
            }
            .onReceive(viewModel.$message) { banner in
                banner?.show()
            }
        }
    }
}
