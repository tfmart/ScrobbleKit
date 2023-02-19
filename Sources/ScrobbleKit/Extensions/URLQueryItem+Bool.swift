//
//  File.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension URLQueryItem {
    init(name: String, bool: Bool) {
        switch bool {
        case true: self.init(name: name, value: "1")
        case false: self.init(name: name, value: "0")
        }
    }
}
