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

//extension DatePickerView {
//    init(name: String, binding: Binding<Parameter>) {
//        self.name = name
//        _date = Binding(
//            get: {
//                binding.wrappedValue as! Date
//            },
//            set: { newValue in
//                binding.wrappedValue = newValue
//            }
//        )
//    }
//}
//
