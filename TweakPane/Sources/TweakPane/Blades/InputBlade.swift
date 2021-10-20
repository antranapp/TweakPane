//
//  InputBlade.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

public enum InputBladeOption {
    case none
    case options(_ options: [String])
    case stepper(range: ClosedRange<Int>)
    case slider(range: ClosedRange<Double>)
}

public struct InputBlade: Blade {
    public let name: String
    let option: InputBladeOption
    var binding: InputBinding

    public init(
        name: String,
        option: InputBladeOption,
        binding: InputBinding
    ) {
        self.name = name
        self.option = option
        self.binding = binding
    }

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

        case .slider(let range):
            SliderView(
                name: name,
                range: range,
                sliderValue: Binding(
                    get: {
                        binding.parameter as! Double
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
    public func render() -> AnyView {
        AnyView(renderInternally())
    }

}
