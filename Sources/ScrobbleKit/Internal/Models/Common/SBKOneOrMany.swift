//
//  SBKOneOrMany.swift
//  
//
//  Created by Tomas Martins on 16/07/26.
//

import Foundation

struct SBKOneOrMany<Element: Decodable>: Decodable {
    let values: [Element]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let values = try? container.decode([Element].self) {
            self.values = values
        } else {
            self.values = [try container.decode(Element.self)]
        }
    }
}

extension SBKOneOrMany: Sendable where Element: Sendable {}

extension KeyedDecodingContainer {
    func decodeOneOrMany<Element: Decodable>(
        _ type: Element.Type,
        forKey key: Key
    ) throws -> [Element] {
        try decode(SBKOneOrMany<Element>.self, forKey: key).values
    }

    func decodeOneOrManyIfPresent<Element: Decodable>(
        _ type: Element.Type,
        forKey key: Key
    ) throws -> [Element]? {
        try decodeIfPresent(SBKOneOrMany<Element>.self, forKey: key)?.values
    }
}
