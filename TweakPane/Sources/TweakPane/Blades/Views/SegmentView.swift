//
//  File.swift
//  
//
//  Created by Binh An Tran on 21/10/21.
//

import Foundation
import SwiftUI

struct SegmentView<Value: Hashable & CustomStringConvertible>: View {
    let name: String
    var values: [Value]
    let style: InputBladeOption.Style
    @Binding var selectedValue: Value

    var body: some View {
        Picker(name, selection: $selectedValue) {
            ForEach(values, id: \.self) {
                Text($0.description)
            }
        }
        .if(style == .menu) {
            $0.pickerStyle(MenuPickerStyle())
        }
        .if(style == .segmented) {
            $0.pickerStyle(SegmentedPickerStyle())
        }

    }
}
