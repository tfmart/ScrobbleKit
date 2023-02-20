//
//  AlbumGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct AlbumGetTopTagsService: SBKService {
    var apiKey: String
    var secretKey: String
    
    typealias ResponseType = SBKAlbumTopTagsResponse
    
    var sbkMethod: SBKMethod = .getTopTagsForAlbum
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(searchMethod: SBKAlbumSearchMethod,
         autoCorrect: Bool,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        switch searchMethod {
        case .albumArtist(let album, let artist):
            self.queries = [
                .init(name: "artist", value: artist),
                .init(name: "album", value: album),
                .init(name: "autocorrect", bool: autoCorrect)
            ]
        case .musicBrainzID(let id):
            self.queries = [
                .init(name: "mbid", value: id),
                .init(name: "autocorrect", bool: autoCorrect)
            ]
        }
    }
}
