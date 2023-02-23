//
//  ChartsGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct ChartGetTopTagsService: SBKService {
    typealias ResponseType = SBKChartGetTopTagsResponse
    
    var sbkMethod: SBKMethod = .tagTopTags
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(page: Int, limit: Int, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "page", numericValue: page),
            .init(name: "limit", numericValue: limit)
        ]
    }
}
