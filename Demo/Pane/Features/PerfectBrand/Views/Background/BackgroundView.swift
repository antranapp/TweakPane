//
//  Backgroundview.swift
//  Demo
//
//  Created by Binh An Tran on 24/10/21.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    let background: Background

    var body: some View {
        switch background.style {
        case .solid(let color):
            Rectangle()
                .fill(color)
        default:
            EmptyView()
        }
    }
}
