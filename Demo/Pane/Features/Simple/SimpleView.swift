//
//  File.swift
//  
//
//  Created by Binh An Tran on 21/10/21.
//

import Foundation
import SwiftUI
import TweakPane

struct SimpleView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            Pane([
                InputBlade(name: "Text", binding: InputBinding($text))
            ]).render()
        }
    }
}
