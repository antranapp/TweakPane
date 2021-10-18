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
}

struct InputBlade: Blade {
    let name: String

    let option: InputBladeOption

    // InputView
    var binding: InputBinding

    @ViewBuilder
    private func renderInternally() -> some View {
        switch option {
        case .none:
            if binding.parameter is Bool {
                ToogleView(value: Binding(
                    get: {
                        binding.parameter as! Bool
                    },
                    set: { newValue in
                        binding.parameter = newValue
                    }
                ))
            }

            if binding.parameter is String {
                TextView(text: Binding(
                    get: {
                        binding.parameter as! String
                    },
                    set: { newValue in
                        binding.parameter = newValue
                    }
                ))
            }
        case .options(let options):
            SegmentView(
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
    @Binding var value: Bool

    var body: some View {
        Toggle(isOn: $value) {
            Text("Bool Value")
        }
    }
}

struct SegmentView<Value: Hashable & CustomStringConvertible>: View {
    var values: [Value]
    @Binding var selectedValue: Value

    var body: some View {
        Picker("Segment Value", selection: $selectedValue) {
            ForEach(values, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

struct TextView: View {
    @Binding var text: String

    var body: some View {
        TextField("Text value", text: $text)
    }
}

