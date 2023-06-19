//
//  SBKArtist.swift
//
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

public struct SBKArtist: Decodable {
    let name: String
    let playcount: String?
    let listeners: String?
    let musicBrainzID: String?
    let url: String?
    let streamable: String?
    internal let image: [SBKImageResponse]?
    
    var images: SBKImage? {
        guard let image else { return nil }
        return SBKImage(response: image)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case playcount
        case listeners
        case musicBrainzID = "mbid"
        case url
        case streamable
        case image
    }
}
