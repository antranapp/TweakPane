//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI
import TweakPane

struct SimpleView: View {
    @State private var text1: String = ""
    @State private var text2: String = ""

    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Text 1:")
                    Text(text1)
                    Spacer()
                }
                HStack {
                    Text("Text 2:")
                    Text(text2)
                    Spacer()
                }
            }

            Divider()

            Pane {
                TextBlade("Constant String")
                InputBlade(name: "Text 1", binding: InputBinding($text1))
                InputBlade(name: "Text 2", binding: InputBinding($text2))
            }

            Divider()

            Pane {
                UIBlade {
                    Button(
                        action: {
                            showingAlert.toggle()
                        },
                        label: {
                            Text("Button")
                        }
                    )
                }
            }
        }
        .sheet(isPresented: $showingAlert) {
            Text("Button tapped")
        }
        .padding()
        .onAppear {
            PaneSettings.shared.showValue = true
        }
        .onDisappear {
            PaneSettings.shared.showValue = false
        }
    }
}
