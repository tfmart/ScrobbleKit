//
//  SBKUserPersonalTags.swift
//  
//
//  Created by Tomas Martins on 17/06/23.
//

import Foundation

struct SBKUserPersonalTagsAttributes: SBKSearchAttribute {
    var user: String
    var tag: String
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}
