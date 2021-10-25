//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct Configuration: Codable, Hashable {
    var padding: Double
    var border: Border
    var perspective: Perspective
    var background: Background
    var watermark: Watermark
}

struct Border: Codable, Hashable {
    var radius: Double
    var width: Double
    var color: Color
}

struct Perspective: Codable, Hashable {
    var rotationX: Double
    var rotationY: Double
    var rotationZ: Double
}

extension Border {
    static let `default` = Border(
        radius: 0,
        width: 0,
        color: .red
    )
}

extension Perspective {
    static let `default` = Perspective(
        rotationX: 0,
        rotationY: 0,
        rotationZ: 0
    )
}

extension Configuration {
    static let `default` = Configuration(
        padding: 0,
        border: .default,
        perspective: .default,
        background: .default,
        watermark: .default
    )
}
