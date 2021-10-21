//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public protocol Parameter {
    var asParameter: Parameter { get set }
}

public extension Parameter {
    var asParameter: Parameter {
        get { self as Parameter }
        set { self = newValue as! Self }
    }
}

extension Bool: Parameter {}
extension String: Parameter {}
extension Character: Parameter {}

extension Date: Parameter {}

extension Int: Parameter {}
extension Double: Parameter {}

extension Color: Parameter {}
