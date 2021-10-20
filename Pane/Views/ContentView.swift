//
//  ContentView.swift
//  Pane
//
//  Created by Binh An Tran on 21/10/21.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PhotoView()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("🍌🍌")
                }
            DemoView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("🍏🍏")
                }

        }
        .font(.headline)
    }
}
