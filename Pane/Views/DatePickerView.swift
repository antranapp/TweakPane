//
//  DatePickerView.swift
//  Pane
//
//  Created by Binh An Tran on 19/10/21.
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
