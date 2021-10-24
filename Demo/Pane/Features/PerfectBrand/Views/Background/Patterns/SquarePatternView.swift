//
// Copyright © 2021 An Tran. All rights reserved.
//

import SwiftUI
import UIKit

struct SquarePatternView: View {

    let pattern: Pattern

    var body: some View {
        GeometryReader { proxy in
            let rows = Int(proxy.size.height / pattern.size)
            let colums = Int(proxy.size.width / pattern.size)
            let gridRows = Array(repeating: GridItem(spacing: 0), count: rows)
            LazyHGrid(rows: gridRows, spacing: 0) {
                ForEach(0 ..< rows * colums) { index in
                    Rectangle()
                        .fill(index % 2 == 0 ? Color(UIColor.lightGray) : Color.white)
                        .frame(width: pattern.size)
                }
            }
        }
    }
}
