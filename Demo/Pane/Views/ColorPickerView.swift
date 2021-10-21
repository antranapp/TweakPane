//
//  File.swift
//  
//
//  Created by Binh An Tran on 21/10/21.
//

import Foundation
import SwiftUI

struct ColorPickerView: View {
    let name: String
    @Binding var color: Color

    var body: some View {
        ColorPicker(name, selection: $color)
    }
}
