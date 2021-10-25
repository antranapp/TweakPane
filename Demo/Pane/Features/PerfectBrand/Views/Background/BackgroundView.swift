//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    let background: Background

    var body: some View {
        VStack {
            switch background.style {
            case .solid:
                Rectangle()
                    .fill(background.color)
            case .square:
                SquarePatternView(size: background.size, color: background.color)
            }
        }
    }
}
