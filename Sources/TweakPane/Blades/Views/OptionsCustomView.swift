//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct OptionsCustomView: View {

    let name: String
    let count: Int
    let viewBuilder: (Int) -> AnyView
    @Binding var selectedValue: Int

    var body: some View {
        HStack {
            ForEach(Array(0..<count), id: \.self) { index in
                viewBuilder(index)
                    .onTapGesture {
                        guard index != selectedValue else { return }
                        selectedValue = index
                    }
            }
        }
        .clipped()
    }
}
