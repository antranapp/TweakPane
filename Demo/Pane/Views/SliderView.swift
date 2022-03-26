//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

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
