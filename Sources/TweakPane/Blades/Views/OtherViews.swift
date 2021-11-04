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

struct StepperView<Value>: View where Value: Comparable & Strideable {
    let name: String
    let range: ClosedRange<Value>
    let step: Value.Stride

    @Binding var stepValue: Value

    var body: some View {
        Stepper(value: $stepValue, in: range, step: step) {
            Text(name)
        }
    }
}

struct SliderView<Value>: View where Value: BinaryFloatingPoint, Value.Stride: BinaryFloatingPoint {
    let name: String
    let range: ClosedRange<Value>
    let step: Value.Stride

    @Binding var sliderValue: Value

    var body: some View {
        VStack(alignment: .leading) {
            Slider(value: $sliderValue, in: range, step: step)
        }
    }
}
