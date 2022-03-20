//
//  File.swift
//  
//
//  Created by An Tran on 20/3/22.
//

import Foundation
import SwiftUI

public struct TextBlade<Content: StringProtocol>: Blade {
    public let name: String
    public let title: () -> Content

    public init(name: String, title: @autoclosure @escaping () -> Content) {
        self.name = name
        self.title = title
    }

    public func render() -> AnyView {
        AnyView(Text(title()))
    }
}
