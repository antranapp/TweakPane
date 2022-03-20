//
//  File.swift
//  
//
//  Created by An Tran on 20/3/22.
//

import Foundation
import SwiftUI

public struct TextBlade<Content: StringProtocol>: Blade {
    public let name: String? = nil
    public let title: () -> Content

    public init(_ title: @autoclosure @escaping () -> Content) {
        self.title = title
    }

    public func render() -> AnyView {
        AnyView(Text(title()))
    }
}
