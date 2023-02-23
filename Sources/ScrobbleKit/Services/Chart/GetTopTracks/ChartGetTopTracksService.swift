//
//  ChartGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct ChartGetTopTracksService: SBKService {
    typealias ResponseType = SBKChartGetTopTracksResponse
    
    var sbkMethod: SBKMethod = .getTopTracksFromChart
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(limit: Int,
         page: Int,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
