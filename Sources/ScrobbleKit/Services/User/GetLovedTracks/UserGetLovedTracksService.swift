//
//  UserGetLovedTracksService.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

struct UserGetLovedTracksService: SBKService {
    typealias ResponseType = _UserGetLovedTracksResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getUserLovedTracks
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(
        user: String,
        limit: Int,
        page: Int,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "user", value: user),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
