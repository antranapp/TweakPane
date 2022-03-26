//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public struct UIBlade<Content: View>: Blade {
    public let name: String? = nil
    public let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public func render() -> AnyView {
        AnyView(content())
    }
}
