//
//  CanvasView.swift
//  Demo
//
//  Created by Binh An Tran on 24/10/21.
//

import Foundation
import SwiftUI

struct CanvasView: View {
    let image: Image
    let configuration: Configuration

    var body: some View {
        VStack { // This VStack helps to center the Canvas in the center
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(configuration.border.color, width: configuration.border.width)
                .cornerRadius(configuration.border.radius)
                .rotation3DEffect(.degrees(configuration.perspective.rotationX), axis: (x: 1, y: 0, z: 0))
                .rotation3DEffect(.degrees(configuration.perspective.rotationY), axis: (x: 0, y: 1, z: 0))
                .rotation3DEffect(.degrees(configuration.perspective.rotationZ), axis: (x: 0, y: 0, z: 1), anchorZ: 0.5)
        }
    }
}
