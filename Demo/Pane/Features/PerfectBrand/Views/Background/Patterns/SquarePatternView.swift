//
// Copyright © 2021 An Tran. All rights reserved.
//

import SwiftUI
import UIKit

struct SquarePatternView: View {

    let size: Double
    let color: Color

    var body: some View {
        GeometryReader { proxy in
            let rows = Int(proxy.size.height / size) + 1
            let columns = Int(proxy.size.width / size) + 1
            VStack(spacing: 0) {
                ForEach(Array(0..<rows), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(Array(0..<columns), id: \.self) { column in
                            Rectangle()
                                .fill((row + column) % 2 == 0 ? color : Color.white)
                                .frame(width: size, height: size)
                        }
                    }
                }
            }
//            LazyHGrid(rows: gridRows, spacing: 0) {
//                ForEach(Array(0 ..< rows * colums), id: \.self) { index in
//                    Rectangle()
//                        .fill(index % 2 == 0 ? color : Color.white)
//                        .frame(width: size, height: size)
//                }
//            }
        }
    }
}
