//
//  Background.swift
//  Demo
//
//  Created by Binh An Tran on 24/10/21.
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
    static let `default` = Background(style: .solid, color: .blue, size: 10)
}
