//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI
import TweakPane

struct ConditionalView: View {
    @State private var text1: String = ""
    @State private var text2: String = ""
    @State private var showingText2: Bool = false

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
                InputBlade(name: "Text 1", binding: InputBinding($text1))

                if showingText2 {
                    InputBlade(name: "Text 2", binding: InputBinding($text2))
                }
            }

            Pane {
                InputBlade(name: "Toggle Text 2", binding: InputBinding($showingText2))
            }
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
