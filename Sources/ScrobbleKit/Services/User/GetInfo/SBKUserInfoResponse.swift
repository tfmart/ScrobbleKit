//
//  SBKUserInfoResponse.swift
//  
//
//  Created by Tomas Martins on 25/04/23.
//

import Foundation

public struct SBKUser {
    public var username: String
    public var realName: String?
    public var image: SBKImage?
    public var country: String?
    public var age: String?
    public var isPro: Bool
    public var playcount: Int
    public var artistCount: String?
    public var playlistsCount: Int?
    public var bootstrap: String?
    public var gender: String?
    public var url: String
    public var type: String?
    public var memberSince: Date
    
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
    let artistCount: String?
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
            if let date = try? container.decode(Date.self, forKey: .unixTime) {
                unixTime = date
            } else {
                let dateString = try container.decode(String.self, forKey: .unixTime)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                if let date = dateFormatter.date(from: dateString) {
                    unixTime = date
                } else {
                    throw NSError(domain: "DateConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert the string to a date."])
                }
            }
            timeString = try container.decode(String.self, forKey: .timeString)
        }
    }
}
