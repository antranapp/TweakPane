//
//  InputBlade.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

enum InputBladeOption {
    case none
    case options(_ options: [String])
    case stepper(range: ClosedRange<Int>)
}

struct InputBlade: Blade {
    let name: String
    let option: InputBladeOption
    var binding: InputBinding

    @ViewBuilder
    private func renderInternally() -> some View {
        switch option {
        case .none:
            if binding.parameter is Bool {
                ToogleView(
                    name: name,
                    value: Binding(
                        get: {
                            binding.parameter as! Bool
                        },
                        set: { newValue in
                            binding.parameter = newValue
                        }
                    ))
            }

            if binding.parameter is String {
                TextView(
                    name: name,
                    text: Binding(
                        get: {
                            binding.parameter as! String
                        },
                        set: { newValue in
                            binding.parameter = newValue
                        }
                    ))
            }

            if binding.parameter is Date {
                DatePickerView(
                    name: name,
                    date: Binding(
                        get: {
                            binding.parameter as! Date
                        },
                        set: { newValue in
                            binding.parameter = newValue
                        }
                    ))
            }
        case .options(let options):
            SegmentView(
                name: name,
                values: options,
                selectedValue: Binding(
                    get: {
                        binding.parameter as! String
                    },
                    set: { newValue in
                        binding.parameter = newValue
                    }
                )
            )

        case .stepper(let range):
            StepperView(
                name: name,
                range: range,
                stepValue: Binding(
                    get: {
                        binding.parameter as! Int
                    },
                    set: { newValue in
                        binding.parameter = newValue
                    }
                )
            )
        }

        Text(String(describing: binding.parameter))
    }

    // TODO: Instead of AnyView, we might want to create a AnyBlade
    // to abstract the underlying concrete blade
    func render() -> AnyView {
        AnyView(renderInternally())
    }

}

struct ToogleView: View {
    let name: String
    @Binding var value: Bool

    var body: some View {
        Toggle(isOn: $value) {
            Text(name)
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

struct StepperView: View {
    let name: String
    let range: ClosedRange<Int>

    @Binding var stepValue: Int

    var body: some View {
        Stepper(value: $stepValue, in: range) {
            Text(name)
        }
    }
}
