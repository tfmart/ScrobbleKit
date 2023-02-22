//
//  SBKArtistGetSimilarResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetSimilarResponse: Decodable {
    var similarartists: SBKArtistGetSimilarList
}

struct SBKArtistGetSimilarList: Decodable {
    var artist: [SBKSimilarArtist]
}

/// Represents an artist that is similar to the one returned by the Last.fm API.
public struct SBKSimilarArtist: Decodable {
    /// The name of the similar artist.
    public var name: String
    /// The MusicBrainz ID associated with the artist. This is an optional property.
    public var musicBrainzID: String?
    /// The Last.fm URL for the similar artist.
    public var url: String
    
    internal var matchString: String
    internal var imageResponse: [SBKImageResponse]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case musicBrainzID = "mbid"
        case matchString = "match"
        case url
        case imageResponse = "image"
    }
    
    /// The image for the similar artist, if available.
    var image: SBKImage? {
        SBKImage(response: imageResponse)
    }
    
    /// The match value for the similarity between the original artist and the similar artist, as a percentage (from 0.0 to 1.0).
    var match: Double? {
        return Double(matchString)
    }
}
