//
//  Parameter.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

public protocol Parameter {
    var asParameter: Parameter { get set }
}

extension Parameter {
    public var asParameter: Parameter {
        get {self as Parameter}
        set {self = newValue as! Self}
    }
}

extension Bool: Parameter {}
extension String: Parameter {}
extension Character: Parameter {}

extension Date: Parameter {}

extension Int: Parameter {}
extension Double: Parameter {}

extension Color: Parameter {}
