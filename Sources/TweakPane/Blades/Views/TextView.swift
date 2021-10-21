//
//  TextView.swift
//  Pane
//
//  Created by Binh An Tran on 19/10/21.
//

import Foundation
import SwiftUI

struct TextView: View {
    let name: String
    @Binding var text: String

    var body: some View {
        TextField(name, text: $text)
    }
}
