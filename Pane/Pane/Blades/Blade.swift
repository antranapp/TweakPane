//
//  Blade.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

protocol Blade {
    var name: String { get }
    func render() -> AnyView
}

protocol BladeContainer: Blade {
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
