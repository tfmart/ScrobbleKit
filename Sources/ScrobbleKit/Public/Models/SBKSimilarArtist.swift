//
//  SBKSimilarArtist.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

/// Represents an artist that is similar to the one returned by the Last.fm API.
public struct SBKSimilarArtist: Decodable {
    internal var name: String
    internal var musicBrainzID: String?
    internal var url: String
    internal var matchString: String
    internal var imageResponse: [SBKImageResponse]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case musicBrainzID = "mbid"
        case matchString = "match"
        case url
        case imageResponse = "image"
    }
    
    /// The artist that this similar artist represents
    public var artist: SBKArtist {
        return SBKArtist(name: name,
        musicBrainzID: musicBrainzID,
                         url: url,
        image: imageResponse)
    }
    
    /// The match value for the similarity between the original artist and the similar artist, as a percentage (from 0.0 to 1.0).
    public var match: Double? {
        return Double(matchString)
    }
}
