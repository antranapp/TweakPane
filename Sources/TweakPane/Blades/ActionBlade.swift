//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public struct ActionBlade<Content: StringProtocol>: Blade {
    public let name: String? = nil
    public let title: String
    public let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public func render() -> AnyView {
        AnyView(Button(title, action: action))
    }
}
