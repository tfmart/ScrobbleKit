//
//  SBKSearchQuery.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKSearchQuery: Codable {
    let text: String
    let role: String
    let searchTerms: String?
    let startPage: String

    private enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role, searchTerms, startPage
    }
}
