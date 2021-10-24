//
//  Background.swift
//  Demo
//
//  Created by Binh An Tran on 24/10/21.
//

import Foundation
import SwiftUI

struct Background: Codable, Hashable {
    enum Style: Codable, Hashable {
        case solid(color: Color)
        case pattern(pattern: Pattern)
    }

    var style: Style
}

extension Background {
    static let `default` = Background(style: .solid(color: Color.blue))
}
