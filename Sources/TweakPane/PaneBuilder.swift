//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation

@resultBuilder
public enum BladesBuilder {
    static func buildBlock() -> [Blade] {
        []
    }
}

public extension BladesBuilder {
    static func buildBlock(_ blades: BladesConvertible...) -> [Blade] {
        blades.flatMap { $0.asBlades() }
    }
}

public extension BladesBuilder {
    static func buildOptional(_ component: [Blade]?) -> [Blade] {
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
