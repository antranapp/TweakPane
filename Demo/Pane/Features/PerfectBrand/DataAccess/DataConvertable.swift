//
//  DataConvertable.swift
//  Demo
//
//  Created by Binh An Tran on 27/10/21.
//

import Foundation
import SwiftUI
import UIKit

protocol DataConvertable {
    var data: Data { get }
}

extension Data: DataConvertable {
    var data: Data {
        self
    }
}

extension UIImage: DataConvertable {
    var data: Data {
        self.pngData() ?? Data()
    }
}
