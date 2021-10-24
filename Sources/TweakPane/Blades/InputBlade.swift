//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public enum InputBladeOption {
    public enum Style {
        case segmented
        case menu
    }

    case `default`
    case options(_ options: [String], style: Style)
    case optionsCustomViews(count: Int, viewBuilder: (Int) -> AnyView)
    case stepperInt(range: ClosedRange<Int>)
    case stepperDouble(range: ClosedRange<Double>)
    case slider(range: ClosedRange<Double>)
}

public struct InputBlade: Blade {
    public let name: String
    let option: InputBladeOption
    var binding: InputBinding

    public init(
        name: String,
        option: InputBladeOption = .default,
        binding: InputBinding
    ) {
        self.name = name
        self.option = option
        self.binding = binding
    }

    @ViewBuilder
    private func renderInternally() -> some View {
        VStack {
            switch option {
            case .default:
                renderDefault()
            case .options(let options, let style):
                SegmentView(
                    name: name,
                    values: options,
                    style: style,
                    selectedValue: Binding(
                        get: {
                            binding.parameter as! String
                        },
                        set: { newValue in
                            binding.parameter = newValue
                        }
                    )
                )

            case let .optionsCustomViews(count, viewBuilder):
                OptionsCustomView(
                    name: name,
                    count: count,
                    viewBuilder: viewBuilder,
                    selectedValue: Binding(
                        get: {
                            binding.parameter as! Int
                        },
                        set: { newValue in
                            binding.parameter = newValue
                        }
                    )
                )


            case .stepperInt(let range):
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

            case .stepperDouble(let range):
                StepperView(
                    name: name,
                    range: range,
                    stepValue: Binding(
                        get: {
                            binding.parameter as! Double
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

            if PaneSettings.shared.showValue {
                Text(String(describing: binding.parameter))
            }
        }
    }

    @ViewBuilder
    private func renderDefault() -> some View {
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
                )
            )
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
                )
            )
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
                )
            )
        }

        if binding.parameter is Color {
            ColorPickerView(
                name: name,
                color: Binding(
                    get: {
                        binding.parameter as! Color
                    },
                    set: { newValue in
                        binding.parameter = newValue
                    }
                )
            )
        }
    }

    // TODO: Instead of AnyView, we might want to create a AnyBlade
    // to abstract the underlying concrete blade
    public func render() -> AnyView {
        AnyView(renderInternally())
    }

}
