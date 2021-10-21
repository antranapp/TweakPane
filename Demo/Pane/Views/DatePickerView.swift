//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct DatePickerView: View {
    let name: String
    @Binding var date: Date

    var body: some View {
        DatePicker(
            name,
            selection: $date,
            displayedComponents: [.date]
        )
    }
}
