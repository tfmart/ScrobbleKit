//
//  SBKScrobbleList.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

// MARK: - Root object
struct SBKScrobbleList: Decodable {
    let scrobbles: SBKScrobbles
}

// MARK: - Scrobbles object
struct SBKScrobbles: Decodable {
    let scrobbles: [SBKScrobble]
    let attr: SBKAttr

    enum CodingKeys: String, CodingKey {
        case scrobbles = "scrobble"
        case attr = "@attr"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKScrobbles.CodingKeys> = try decoder.container(keyedBy: SBKScrobbles.CodingKeys.self)
        
        if let scrobbleList = try? container.decode([SBKScrobble].self, forKey: SBKScrobbles.CodingKeys.scrobbles) {
            self.scrobbles = scrobbleList
        } else {
            let singleEntry = try container.decode(SBKScrobble.self, forKey: SBKScrobbles.CodingKeys.scrobbles)
            self.scrobbles = [singleEntry]
        }
        self.attr = try container.decode(SBKAttr.self, forKey: SBKScrobbles.CodingKeys.attr)
    }
}

// MARK: - Attr object
struct SBKAttr: Decodable {
    let ignored, accepted: Int
}

// MARK: - Scrobble object
struct SBKScrobble: Decodable {
    let artist: SBKScrobbleAttribute
    let album: SBKScrobbleAttribute
    let track: SBKScrobbleAttribute
    let ignoredMessage: SBKIgnoredMessage
    let albumArtist: SBKScrobbleAttribute
    let timestamp: String
}

struct SBKScrobbleAttribute: Decodable {
    let corrected, text: String?

    enum CodingKeys: String, CodingKey {
        case corrected
        case text = "#text"
    }
}

// MARK: - IgnoredMessage object
struct SBKIgnoredMessage: Decodable {
    let code, text: String

    enum CodingKeys: String, CodingKey {
        case code
        case text = "#text"
    }
}

