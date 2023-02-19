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
        album: String,
        artist: String,
        musicBrainzID: String?,
        autoCorrect: Bool,
        username: String?,
        languageCode: SBKLanguageCode,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.queries = [
            .init(name: "album", value: album),
            .init(name: "artist", value: artist),
            .init(name: "mbid", value: musicBrainzID),
            .init(name: "username", value: nil),
            .init(name: "autocorrect", bool: autoCorrect)
        ]
    }
}
