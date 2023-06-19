//
//  SBKSearchAttribute.swift
//  
//
//  Created by Tomas Martins on 17/06/23.
//

import Foundation

protocol SBKSearchAttribute: Decodable {
    var page: String { get set }
    var perPage: String { get set }
    var totalPages: String { get set }
    var total: String { get set }
}
