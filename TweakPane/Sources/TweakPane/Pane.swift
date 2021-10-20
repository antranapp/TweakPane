//
//  Pane.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI
import Combine

// Pane -> Blade -> Binding/Monitoring
// Use Sourcery to create a Pane for a View automatically by analysing the internal @State

// TODO:
// - Missing Panes:

public final class Pane {
    private var blades: [Blade]

    public init(_ blades: [Blade]) {
        self.blades = blades
    }

    public func render() -> some View {
        PaneView(blades)
    }
}
