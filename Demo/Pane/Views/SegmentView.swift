//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct SegmentView<Value: Hashable & CustomStringConvertible>: View {
    let name: String
    var values: [Value]
    @Binding var selectedValue: Value

    var body: some View {
        Picker(name, selection: $selectedValue) {
            ForEach(values, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
