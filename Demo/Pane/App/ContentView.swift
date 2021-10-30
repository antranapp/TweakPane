//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SimpleView()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Simple")
                }
            ConditionalView()
                .tabItem {
                    Image(systemName: "2.circle.fill")
                    Text("Conditional")
                }
            PhotoView()
                .tabItem {
                    Image(systemName: "3.circle.fill")
                    Text("Photo")
                }
            DemoView()
                .tabItem {
                    Image(systemName: "4.square.fill")
                    Text("Demo")
                }
            PerfectBrandView()
                .tabItem {
                    Image(systemName: "5.circle.fill")
                    Text("Complex")
                }
        }
        .onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}
