//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct ToogleView: View {
    let name: String
    @Binding var value: Bool

    var body: some View {
        Toggle(isOn: $value) {
            Text(name)
        }
    }
}
