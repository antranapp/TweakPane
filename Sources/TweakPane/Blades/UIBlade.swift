//
//  File.swift
//  
//
//  Created by Binh An Tran on 29/11/21.
//

import Foundation
import SwiftUI

public struct UIBlade<Content: View>: Blade {
    public let name: String? = nil
    public let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public func render() -> AnyView {
        AnyView(content())
    }
}
