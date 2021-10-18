//
//  MonitoringBlade.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

struct MonitoringBlade: Blade {
    var name: String
    // MonitoringView

    let binding: MonitorBinding

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
    func render() -> AnyView {
        AnyView(renderInternally())
    }

}

