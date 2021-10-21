//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public protocol Blade {
    var name: String { get }
    func render() -> AnyView
}

public protocol BladeContainer: Blade {
    var blades: [Blade] { get }
}

extension BladeContainer {
    @ViewBuilder
    private func renderInternally() -> some View {
        Text("Render")
    }

    func render() -> AnyView {
        AnyView(renderInternally())
    }
}
