//
//  TagGetInfoService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct TagGetInfoService: SBKService {
    typealias ResponseType = TagGetInfoResponse
    
    var tag: String
    var language: SBKLanguageCode
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(tag: String, language: SBKLanguageCode, apiKey: String, secretKey: String) {
        self.tag = tag
        self.language = language
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "tag", value: tag)
        ]
        self.queries.append(.init(name: "lang", value: language.rawValue))
    }
}

struct TagGetInfoResponse: Decodable {
    let tag: SBKTag
}
