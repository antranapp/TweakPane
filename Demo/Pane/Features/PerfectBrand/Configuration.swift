//
//  Configuration.swift
//  Demo
//
//  Created by Binh An Tran on 24/10/21.
//

import Foundation
import SwiftUI

struct Configuration: Codable, Hashable {
    var border: Border
    var perspective: Perspective
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
        border: .default,
        perspective: .default
    )
}
