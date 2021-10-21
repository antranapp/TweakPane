//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public struct MonitoringBlade: Blade {
    public var name: String
    let binding: MonitorBinding

    public init(
        name: String,
        binding: MonitorBinding
    ) {
        self.name = name
        self.binding = binding
    }

    @ViewBuilder
    private func renderInternally() -> some View {
        if binding.parameter is Bool {
            Text(String(describing: binding.parameter))
        }

        if binding.parameter is String {
            Text(String(describing: binding.parameter))
        }
    }

    // TODO: Instead of AnyView, we might want to create a AnyBlade
    // to abstract the underlying concrete blade
    public func render() -> AnyView {
        AnyView(renderInternally())
    }

}
