//
//  StepperView.swift
//  Pane
//
//  Created by Binh An Tran on 21/10/21.
//

import Foundation
import SwiftUI

struct StepperView<Value>: View where Value: Comparable & Strideable {
    let name: String
    let range: ClosedRange<Value>

    @Binding var stepValue: Value

    var body: some View {
        Stepper(value: $stepValue, in: range) {
            Text(name)
        }
    }
}