//
//  File.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKArtistTopChartsRequestResponse: Decodable {
    let artists: SBKArtistListResponse
}

struct SBKArtistListResponse: Decodable {
    let artists: [SBKArtist]
    
    enum CodingKeys: String, CodingKey {
        case artists = "artist"
    }
}

public struct SBKArtist: Decodable {
    let name: String
    let playcount: String?
    let listeners: String
    let musicBrainzID: String?
    let url: String?
    let streamable: String?
    internal let image: [SBKImageResponse]?
    
    var images: SBKImage? {
        guard let image else { return nil }
        return SBKImage(response: image)
    }
}
