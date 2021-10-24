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
        VStack {
            switch background.style {
            case .solid:
                Rectangle()
                    .fill(background.color)
            case .square:
                SquarePatternView(size: background.size, color: background.color)
            }
        }
    }
}
