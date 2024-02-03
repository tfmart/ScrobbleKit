//
//  OptinalStringInitializers.swift
//
//
//  Created by Tomas Martins on 02/02/24.
//

import Foundation

extension URL {
    init?(optionalString: String?) {
        guard let optionalString, let url = URL(string: optionalString) else { return nil }
        self = url
    }
}

extension Int {
    init?(optionalString: String?) {
        guard let optionalString, let integerValue = Int(optionalString) else { return nil }
        self = integerValue
    }
}

extension UUID {
    init?(optionalString: String?) {
        guard let optionalString, let uuid = UUID(uuidString: optionalString) else { return nil }
        self = uuid
    }
}
