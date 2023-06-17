//
//  LibraryGetArtistsService.swift
//  
//
//  Created by Tomas Martins on 24/02/23.
//

import Foundation

struct LibraryGetArtistsService: SBKService {
    typealias ResponseType = SBKLibraryGetArtistsResponse
    
    var sbkMethod: SBKMethod = .libraryArtists
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    init(user: String, limit: Int, page: Int, apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secretKey = secret
        
        self.queries = [
            .init(name: "user", value: user),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
