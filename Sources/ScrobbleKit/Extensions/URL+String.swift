//
//  URL+String.swift
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
