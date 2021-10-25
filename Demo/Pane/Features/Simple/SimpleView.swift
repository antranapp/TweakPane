//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI
import TweakPane

struct SimpleView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            Pane([
                InputBlade(name: "Text", binding: InputBinding($text)),
            ])
        }
    }
}
