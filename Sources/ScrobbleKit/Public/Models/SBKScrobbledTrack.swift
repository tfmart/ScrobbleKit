//
//  SBKScrobbledTrack.swift
//  
//
//  Created by Tomas Martins on 26/08/23.
//

import Foundation

public struct SBKScrobbledTrack: Decodable {
    public let track: SBKTrack
    public let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case mbid
        case url
        case date
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKScrobbledTrack.CodingKeys> = try decoder.container(keyedBy: SBKScrobbledTrack.CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let artist = try container.decode(SBKArtist.self, forKey: .artist)
        let url = try container.decode(String.self, forKey: .url)
        let mbid = try container.decodeIfPresent(String.self, forKey: .mbid)
        self.track = .init(
            name: name,
            mbid: mbid,
            artist: artist,
            url: URL(string: url)
        )
        let timestamp = try container.decode(SBKTimestamp.self, forKey: .date)
        if let timeInterval = TimeInterval(timestamp.timestamp) {
            self.date = Date(timeIntervalSince1970: timeInterval)
        } else {
            self.date = nil
        }
    }
}
