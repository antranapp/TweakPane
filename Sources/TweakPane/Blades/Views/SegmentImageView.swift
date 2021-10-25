//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct SegmentImageView: View {
    let name: String
    var values: [Image]
    @Binding var selectedValue: Int

    var body: some View {
        Picker(name, selection: $selectedValue) {
            ForEach(values.indices, id: \.self) {
                values[$0]
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
