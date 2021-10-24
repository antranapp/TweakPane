//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct PaneView: View {

    let blades: [Blade]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // TODO: Find a way so that we can get rid of interating over indices
            ForEach(blades.indices, id: \.self) { index in
                Section(title: blades[index].name) {
                    VStack {
                        blades[index].render()
                    }
                }
            }
        }
    }
}
