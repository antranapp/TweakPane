//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

public protocol Blade {
    var name: String { get }
    func render() -> AnyView
}

public struct FolderBlade: Blade {
    public var name: String

    let blades: [Blade]

    public init(_ name: String, blades: [Blade]) {
        self.name = name
        self.blades = blades
    }

    @ViewBuilder
    private func renderInternally() -> some View {
        VStack(spacing: 20) {
            // TODO: Find a way so that we can get rid of interating over indices
            ForEach(blades.indices, id: \.self) { index in
                Section(title: blades[index].name) {
                    VStack {
                        blades[index].render()
                    }
                }
            }
        }
        .padding(.leading, 20)
    }

    public func render() -> AnyView {
        AnyView(renderInternally())
    }
}
