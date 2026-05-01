//
//  AlbumGetTagsService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct AlbumGetTagsService: SBKOptionallyAuthenticatedService {
    var username: String?
    var sessionKey: String?

    var apiKey: String
    var secretKey: String
    
    typealias ResponseType = SBKAddTagAlbumResponse
    
    var sbkMethod: SBKMethod = .getTagsForAlbum
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(searchMethod: SBKAlbumSearchMethod,
         autoCorrect: Bool,
         username: String?,
         apiKey: String,
         secretKey: String,
         sessionKey: String?) {
        self.username = username
        self.sessionKey = sessionKey
        self.apiKey = apiKey
        self.secretKey = secretKey
        switch searchMethod {
        case .albumArtist(let album, let artist):
            self.queries = [
                .init(name: "artist", value: artist),
                .init(name: "album", value: album),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect)
            ]
        case .musicBrainzID(let id):
            self.queries = [
                .init(name: SBKParameter.musicBrainzID.rawValue, value: id),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect)
            ]
        }
    }
}
