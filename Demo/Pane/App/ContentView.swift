//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PhotoView()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Photo")
                }
            DemoView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Demo")
                }
            SimpleView()
                .tabItem {
                    Image(systemName: "3.circle.fill")
                    Text("Simple")
                }
            PerfectBrandView()
                .tabItem {
                    Image(systemName: "4.circle.fill")
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
