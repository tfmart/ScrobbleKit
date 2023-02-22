//
//  File.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

extension Bool {
    init?(integer: Int?) {
        guard let integer else { return nil }
        self = integer != 0
    }
}
