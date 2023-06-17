//
//  SBKUserGetFriendsResponse.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

struct SBKUserGetFriendsRootObject: Decodable {
    let friends: SBKUserGetFriendsResponse
}

struct SBKUserGetFriendsResponse: Decodable {
    let attributes: SBKUserGetFriendsAttribute
    let friends: [SBKUserInfoDataResponse]
    
    private enum CodingKeys: String, CodingKey {
        case friends = "user"
        case attributes = "@attr"
    }
}

struct SBKUserGetFriendsAttribute: Decodable {
    var user: String
    var totalPages: String
    var page: String
    var total: String
    var perPage: String
}
