//
// Copyright © 2021 An Tran. All rights reserved.
//

import SwiftUI

@main
struct PaneApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView()
            #elseif os(macOS)
            ContentViewMac()
            #endif
        }
    }
}
