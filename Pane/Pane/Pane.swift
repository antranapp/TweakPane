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

final class Pane {
    private var blades: [Blade]

    init(_ blades: [Blade]) {
        self.blades = blades
    }

    func render() -> some View {
        PaneView(blades)
    }
}
