//
// Copyright © 2021 An Tran. All rights reserved.
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
