//
//  PreviewView.swift
//  Demo
//
//  Created by Binh An Tran on 29/10/21.
//

import Foundation
import SwiftUI
import UIKit

struct PreviewView: View {
    @Environment(\.presentationMode) private var presentationMode

    @State var folderName: String

    let image: UIImage
    let configuration: Configuration

    let callback: (String) -> Void

    var body: some View {
        VStack {

            CanvasView(image: Image(uiImage: image), configuration: configuration)

            VStack {

                TextField("Enter a name", text: $folderName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(
                    action: {
                        guard !folderName.isEmpty else {
                            return
                        }

                        callback(folderName)

                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Save")
                    }
                )
            }
            .padding()
        }
    }
}
