//
//  File.swift
//  
//
//  Created by Binh An Tran on 31/10/21.
//

import Foundation

@resultBuilder
public struct BladesBuilder {
    static func buildBlock()-> [Blade] {
        []
    }
}

public extension BladesBuilder {
    static func buildBlock(_ blades: BladesConvertible...) -> [Blade] {
        blades.flatMap { $0.asBlades() }
    }
}

extension BladesBuilder {
    public static func buildOptional(_ component: [Blade]?) -> [Blade] {
        component ?? []
    }
}

extension Array: BladesConvertible where Element == Blade {
    public func asBlades() -> [Blade] { self }
}

extension BladesBuilder {
    static func buildEither(first: BladesConvertible) -> BladesConvertible {
        first
    }

    static func buildEither(second: BladesConvertible) -> BladesConvertible {
        second
    }
}
