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
        if let empty = try? container.decode(String.self, forKey: .friends), empty.isEmpty {
            self.friends = []
        } else {
            self.friends = try container.decodeOneOrManyIfPresent(SBKUserInfoDataResponse.self, forKey: .friends) ?? []
        }
    }
}

struct SBKUserGetFriendsAttribute: Decodable, Sendable {
    var user: String
    var totalPages: String
    var page: String
    var total: String
    var perPage: String
}
