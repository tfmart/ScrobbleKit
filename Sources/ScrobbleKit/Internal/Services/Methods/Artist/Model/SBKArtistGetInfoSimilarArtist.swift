//
//  SBKArtistGetInfoSimilarArtist.swift
//
//
//  Created by Tomas Martins on 02/02/24.
//

import Foundation

/// Represents a similar artist for an artist.
struct SBKArtistGetInfoSimilarArtist: Decodable {
    public var name: String
    public var url: String
    private var imageResponse: [SBKImageResponse]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case imageResponse = "image"
    }
    
    var image: SBKImage? {
        return .init(response: imageResponse)
    }
}
