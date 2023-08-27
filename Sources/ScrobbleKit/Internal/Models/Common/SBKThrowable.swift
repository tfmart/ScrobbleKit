//
//  SBKThrowable.swift
//
//
//  Created by Tomas Martins on 26/08/23.
//

import Foundation

struct SBKThrowable<D : Decodable> : Decodable {

    let object: D?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.object = try? container.decode(D.self)
    }
}
