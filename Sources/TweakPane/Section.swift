//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct Section<Content: View>: View {
    let title: String?
    let content: () -> Content

    init(title: String?, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(.caption)
                    .foregroundColor(Color.secondary)
            }
            content()
        }
    }
}
