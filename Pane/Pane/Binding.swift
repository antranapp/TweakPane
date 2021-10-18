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

struct MonitorBinding {
    @Binding var parameter: Parameter
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
