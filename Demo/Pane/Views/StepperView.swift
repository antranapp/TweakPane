//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct StepperView<Value>: View where Value: Comparable & Strideable {
    let name: String
    let range: ClosedRange<Value>

    @Binding var stepValue: Value

    var body: some View {
        Stepper(value: $stepValue, in: range) {
            Text(String(describing: stepValue))
        }
    }
}
