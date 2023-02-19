//
//  File.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct ChartGetTopArtistsService: SBKService {
    typealias ResponseType = SBKArtistTopChartsRequestResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getTopArtistsFromChart
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(limit: Int, page: Int,
         apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        queries = [
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page),
        ]
    }
}

