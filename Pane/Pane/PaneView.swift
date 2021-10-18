//
//  PaneView.swift
//  Pane
//
//  Created by An Tran on 18/10/21.
//

import Foundation
import SwiftUI

struct PaneView: View {

    let blades: [Blade]

    init(_ blades: [Blade]) {
        self.blades = blades
    }

    var body: some View {
        Form {
            // TODO: Find a way so that we can get rid of interating over indices
            ForEach(blades.indices, id: \.self ){ index in
                Section(header: Text(blades[index].name)) {
                    VStack {
                        blades[index].render()
                    }

                }
            }
        }
    }
}
