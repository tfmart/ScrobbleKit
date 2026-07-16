//
//  SBKUserGetFriendsResponse.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

struct SBKUserGetFriendsRootObject: Decodable, Sendable {
    let friends: SBKUserGetFriendsResponse
}

struct SBKUserGetFriendsResponse: Decodable, Sendable {
    let attributes: SBKUserGetFriendsAttribute
    let friends: [SBKUserInfoDataResponse]
    
    private enum CodingKeys: String, CodingKey {
        case friends = "user"
        case attributes = "@attr"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try container.decode(SBKUserGetFriendsAttribute.self, forKey: .attributes)
        self.friends = try container.decodeOneOrMany(SBKUserInfoDataResponse.self, forKey: .friends)
    }
}

struct SBKUserGetFriendsAttribute: Decodable, Sendable {
    var user: String
    var totalPages: String
    var page: String
    var total: String
    var perPage: String
}
