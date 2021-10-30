//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

// Pane -> Blade -> Binding/Monitoring

public final class PaneSettings: ObservableObject {
    public static let shared = PaneSettings()

    @Published public var showValue: Bool = false

    private init() {}
}

public struct Pane: View {
    @StateObject private var settings = PaneSettings.shared
    public var blades: [Blade]

    public init(_ blades: [Blade]) {
        self.blades = blades
    }

    public var body: some View {
        PaneView(blades: blades)
    }
}

public extension Pane {
    init(@BladesBuilder _ content: () -> [Blade]) {
        blades = content()
    }
}
