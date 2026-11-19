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
    let attributes: SBKUserGetFriendsAttribute?
    let friends: [SBKUserInfoDataResponse]
    
    private enum CodingKeys: String, CodingKey {
        case friends = "user"
        case attributes = "@attr"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try? container.decodeIfPresent(SBKUserGetFriendsAttribute.self, forKey: .attributes)
        if let empty = try? container.decode(String.self, forKey: .friends), empty.isEmpty {
            self.friends = []
        } else {
            self.friends = try container.decodeOneOrManyIfPresent(SBKUserInfoDataResponse.self, forKey: .friends) ?? []
        }
    }
}

struct SBKUserGetFriendsAttribute: Decodable, Sendable {
    let user: String?
    let totalPages: String?
    let page: String?
    let total: String?
    let perPage: String?

    private enum CodingKeys: String, CodingKey {
        case user, totalPages, page, total, perPage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try? container.decodeIfPresent(String.self, forKey: .user)
        totalPages = try? container.decodeIfPresent(String.self, forKey: .totalPages)
        page = try? container.decodeIfPresent(String.self, forKey: .page)
        total = try? container.decodeIfPresent(String.self, forKey: .total)
        perPage = try? container.decodeIfPresent(String.self, forKey: .perPage)
    }
}
