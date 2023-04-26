//
//  SBKUserInfoResponse.swift
//  
//
//  Created by Tomas Martins on 25/04/23.
//

import Foundation

public struct SBKUser {
    var username: String
    var realName: String?
    var image: SBKImage?
    var country: String?
    var age: String?
    var isPro: Bool
    var playcount: Int
    var artistCount: String
    var playlistsCount: Int?
    var bootstrap: String?
    var gender: String?
    var url: String
    var type: String?
    var memberSince: Date
    
    init(from response: SBKUserInfoDataResponse) {
        self.username = response.name
        self.realName = response.realName
        self.image = .init(response: response.imageURL)
        self.country = response.country
        self.age = response.age
        if let subscriber = response.subscriber {
            self.isPro = (subscriber as NSString).boolValue
        } else {
            self.isPro = false
        }
        self.playcount = Int(response.playcount) ?? 0
        self.artistCount = response.artistCount
        self.playlistsCount = Int(response.playlists ?? "")
        self.bootstrap = response.bootstrap
        self.gender = response.gender
        self.url = response.url
        self.type = response.type
        self.memberSince = response.registered.unixTime
    }
}

struct SBKUserInfoResponse: Decodable {
    var user: SBKUserInfoDataResponse
}

struct SBKUserInfoDataResponse: Decodable {
    let name: String
    let realName: String?
    let imageURL: [SBKImageResponse]?
    let country: String?
    let age: String?
    let gender: String?
    let playcount: String
    let artistCount: String
    let playlists: String?
    let registered: SBKRegisteredInfo
    let bootstrap: String?
    let subscriber: String?
    let url: String
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case realName = "realname"
        case imageURL = "image"
        case country
        case age
        case gender
        case playcount
        case playlists
        case registered
        case bootstrap
        case subscriber
        case artistCount = "artist_count"
        case url
        case type
    }
    
    struct SBKRegisteredInfo: Decodable {
        let unixTime: Date
        let timeString: String
        
        private enum CodingKeys: String, CodingKey {
            case unixTime = "#text"
            case timeString = "unixtime"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            unixTime = try container.decode(Date.self, forKey: .unixTime)
            timeString = try container.decode(String.self, forKey: .timeString)
        }
    }
}