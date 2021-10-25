//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct Background: Codable, Hashable {
    enum Style: Codable, Hashable, CaseIterable {
        case solid
        case square
    }

    var style: Style
    var color: Color
    var size: Double
}

extension Background {
    static let `default` = Background(
        style: .solid,
        color: .blue,
        size: 10
    )
}
