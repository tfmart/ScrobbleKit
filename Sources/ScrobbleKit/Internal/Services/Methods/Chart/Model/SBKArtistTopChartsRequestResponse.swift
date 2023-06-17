//
//  SBKArtistTopChartsRequestResponse.swift
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


