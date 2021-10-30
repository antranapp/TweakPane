//
//  File.swift
//  
//
//  Created by Binh An Tran on 31/10/21.
//

import Foundation

@resultBuilder
public struct BladeBuilder {
    static func buildBlock()-> [Blade] {
        []
    }
}

public extension BladeBuilder {
    static func buildBlock(_ blades: Blade...) -> [Blade] {
        blades
    }
}
