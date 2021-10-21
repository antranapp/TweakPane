//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

// Pane -> Blade -> Binding/Monitoring

public final class Pane {
    private var blades: [Blade]

    public init(_ blades: [Blade]) {
        self.blades = blades
    }

    public func render() -> some View {
        PaneView(blades)
    }
}
