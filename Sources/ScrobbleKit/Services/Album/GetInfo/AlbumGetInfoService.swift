//
//  AlbumGetInfoService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct AlbumGetInfoService: SBKService {
    var apiKey: String
    var secretKey: String

    typealias ResponseType = SBKAlbumRequestResponseList
    
    var sbkMethod: SBKMethod = .getAlbumInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(
        searchMethod: SBKAlbumSearchMethod,
        autoCorrect: Bool,
        username: String?,
        languageCode: SBKLanguageCode,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        switch searchMethod {
        case .albumArtist(let album, let artist):
            self.queries = [
                .init(name: "artist", value: artist),
                .init(name: "album", value: album),
                .init(name: "autocorrect", bool: autoCorrect),
                .init(name: "user", value: username),
                .init(name: "lang", value: languageCode.rawValue)
            ]
        case .musicBrainzID(let id):
            self.queries = [
                .init(name: "mbid", value: id),
                .init(name: "autocorrect", bool: autoCorrect),
                .init(name: "user", value: username),
                .init(name: "lang", value: languageCode.rawValue)
            ]
        }
    }
}
