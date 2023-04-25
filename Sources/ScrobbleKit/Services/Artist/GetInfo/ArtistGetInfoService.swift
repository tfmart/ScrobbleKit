//
//  ArtistGetInfoService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct ArtistGetInfoService: SBKService {
    typealias ResponseType = SBKArtistGetInfoRequestResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getArtistInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(
        searchMethod: SBKArtistSearchMethod,
        autoCorrect: Bool,
        username: String?,
        languageCode: SBKLanguageCode,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        switch searchMethod {
        case .artistName(let artist):
            self.queries = [
                .init(name: "artist", value: artist),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
                .init(name: "user", value: username),
                .init(name: "lang", value: languageCode.rawValue)
            ]
        case .musicBrainzID(let id):
            self.queries = [
                .init(name: SBKParameter.musicBrainzID.rawValue, value: id),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
                .init(name: "user", value: username),
                .init(name: "lang", value: languageCode.rawValue)
            ]
        }
    }
}
