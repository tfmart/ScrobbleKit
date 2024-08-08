//
//  TagGetInfoService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

import Foundation

struct TagGetInfoService: SBKService {
    typealias ResponseType = TagGetInfoResponse
    
    var tag: String
    var language: String?
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(tag: String, language: String?, apiKey: String, secretKey: String) {
        self.tag = tag
        self.language = language
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "tag", value: tag)
        ]
        if let language = language {
            self.queries.append(.init(name: "lang", value: language))
        }
    }
}

struct TagGetInfoResponse: Decodable {
    let tag: SBKTag
}
