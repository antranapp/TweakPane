//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct OptionsCustomView<Content: View>: View {
    
    let name: String
    let count: Int
    @ViewBuilder let viewBuilder: (Int) -> Content
    @Binding var selectedValue: Int
    
    var body: some View {
        HStack {
            ForEach(Array(0 ..< count), id: \.self) { index in
                viewBuilder(index)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        guard index != selectedValue else { return }
                        selectedValue = index
                    }
            }
        }
    }
}
