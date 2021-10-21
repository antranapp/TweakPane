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

struct SliderView<Value>: View where Value: BinaryFloatingPoint, Value.Stride: BinaryFloatingPoint {
    let name: String
    let range: ClosedRange<Value>

    @Binding var sliderValue: Value

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Slider(value: $sliderValue, in: range)
        }
    }
}

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
