//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct WatermarkView: View {

    let watermark: Watermark

    var body: some View {
        ZStack(alignment: Alignment(watermark.position)) {
            Rectangle().foregroundColor(.clear) // Need this so that the align of ZStack works correctly.
            Text(watermark.text)
                .font(.body)
                .foregroundColor(Color.white)
                .padding(8)
                .background(Color.black.opacity(0.6))
                .cornerRadius(6)
                .padding(10)
        }
    }
}

extension Alignment {
    init(_ position: Watermark.Position) {
        switch position {
        case .topLeft:
            self = .topLeading
        case .topRight:
            self = .topTrailing
        case .bottomLeft:
            self = .bottomLeading
        case .bottomRight:
            self = .bottomTrailing
        }
    }
}
