//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation

public extension Encodable {
    var prettyPrintedJSONString: String? {
        return try? toPrettyPrintedJSONString()
    }

    private func toPrettyPrintedJSONString() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        guard let result = String(data: data, encoding: .utf8) else {
            throw EncodableError.prettyPrintedStringConversionError
        }
        return result
    }

}

public enum EncodableError: Error {
    case prettyPrintedStringConversionError
}
