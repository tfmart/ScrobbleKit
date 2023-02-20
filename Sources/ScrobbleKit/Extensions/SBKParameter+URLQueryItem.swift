//
//  SBKParameter+URLQueryItem.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension URLQueryItem {
    init(parameter: SBKParameter, value: String?) {
        self.init(name: parameter.rawValue, value: value)
    }
}
