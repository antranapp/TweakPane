//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation

struct Watermark: Codable, Hashable {
    enum Position: Codable, Hashable {
        case topLeft, topRight, bottomLeft, bottomRight
    }

    var text: String
    var position: Position
}

extension Watermark {
    static let `default` = Watermark(
        text: "antran.app",
        position: .bottomLeft
    )
}
