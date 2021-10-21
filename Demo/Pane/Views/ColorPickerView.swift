//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct ColorPickerView: View {
    let name: String
    @Binding var color: Color

    var body: some View {
        ColorPicker(name, selection: $color)
    }
}
