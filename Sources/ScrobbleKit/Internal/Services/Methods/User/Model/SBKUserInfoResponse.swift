//
//  SBKUserInfoResponse.swift
//  
//
//  Created by Tomas Martins on 25/04/23.
//

import Foundation

/// Represents a user on Last.fm, providing various details about their profile and activity.
public struct SBKUser {
    /// The username of the Last.fm user.
    public var username: String
    
    /// The real name of the user, if provided.
    public var realName: String?
    
    /// The profile image of the user.
    public var image: SBKImage?
    
    /// The country of the user, if provided.
    public var country: String?
    
    /// The age of the user, if provided.
    public var age: String?
    
    /// Indicates whether the user has a Last.fm Pro account.
    public var isPro: Bool
    
    /// The total number of tracks played by the user.
    public var playcount: Int
    
    /// The number of unique artists in the user's library.
    public var artistCount: String?
    
    /// The number of playlists created by the user.
    public var playlistsCount: Int?
    
    /// The bootstrap value for the user, if available.
    public var bootstrap: String?
    
    /// The gender of the user, if provided.
    public var gender: String?
    
    /// The URL of the user's Last.fm profile.
    public var url: String
    
    /// The type of the user account.
    public var type: String?
    
    /// The date when the user joined Last.fm.
    public var memberSince: Date
    
    /// Initializes a new `SBKUser` instance from a Last.fm API response.
    ///
    /// - Parameter response: The API response containing user information.
    
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
