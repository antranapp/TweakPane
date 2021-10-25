//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct TextView: View {
    let name: String
    @Binding var text: String

    var body: some View {
        TextField(name, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
