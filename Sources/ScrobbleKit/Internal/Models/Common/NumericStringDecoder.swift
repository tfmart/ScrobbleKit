//
//  NumericStringDecoder.swift
//
//
//  Created by Tomas Martins on 02/02/24.
//

import Foundation

struct IntegerStringDecoder: Decodable {
    var intValue: Int?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let stringValue = try? container.decode(String.self) {
                self.intValue = Int(stringValue)
            } else {
                self.intValue = try? container.decode(Int.self)
            }
        }
}
