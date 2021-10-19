//
//  Binding.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

struct InputBinding {
    @Binding var parameter: Parameter
}

extension InputBinding {
    init(_ value: Binding<String>) {
        _parameter = value.asParameterBinding
    }

    init(_ value: Binding<Date>) {
        _parameter = value.asParameterBinding
    }

    init(_ value: Binding<Bool>) {
        _parameter = value.asParameterBinding
    }

    init(_ value: Binding<Int>) {
        _parameter = value.asParameterBinding
    }

    init(_ value: Binding<Double>) {
        _parameter = value.asParameterBinding
    }
}

struct MonitorBinding {
    @Binding var parameter: Parameter
}

extension MonitorBinding {
    init(_ value: Binding<String>) {
        _parameter = value.asParameterBinding
    }

    init(_ value: Binding<Date>) {
        _parameter = value.asParameterBinding
    }

    init(_ value: Binding<Bool>) {
        _parameter = value.asParameterBinding
    }
}

extension Binding where Value == Bool {
    var asParameterBinding: Binding<Parameter> {
        Binding<Parameter>(
            get: {
                wrappedValue
            },
            set: { newValue in
                wrappedValue = newValue as! Bool
            }
        )
    }
}

extension Binding where Value == String {
    var asParameterBinding: Binding<Parameter> {
        Binding<Parameter>(
            get: {
                wrappedValue
            },
            set: { newValue in
                wrappedValue = newValue as! String
            }
        )
    }
}

extension Binding where Value == Date {
    var asParameterBinding: Binding<Parameter> {
        Binding<Parameter>(
            get: {
                wrappedValue
            },
            set: { newValue in
                wrappedValue = newValue as! Date
            }
        )
    }
}

extension Binding where Value == Int {
    var asParameterBinding: Binding<Parameter> {
        Binding<Parameter>(
            get: {
                wrappedValue
            },
            set: { newValue in
                wrappedValue = newValue as! Int
            }
        )
    }
}

extension Binding where Value == Double {
    var asParameterBinding: Binding<Parameter> {
        Binding<Parameter>(
            get: {
                wrappedValue
            },
            set: { newValue in
                wrappedValue = newValue as! Double
            }
        )
    }
}
