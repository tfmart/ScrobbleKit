//
//  URLQuertyItem+Numeric.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension URLQueryItem {
    init<N: Numeric & CustomStringConvertible>(name: String, numericValue: N?) {
        if let numericValue {
            self.init(name: name, value: "\(numericValue)")
        } else {
            self.init(name: name, value: nil)
        }
    }
}
