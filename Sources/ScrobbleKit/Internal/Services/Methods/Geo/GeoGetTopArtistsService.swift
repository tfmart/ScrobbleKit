//
//  GeoGetTopArtistsService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct GeoGetTopArtistsService: SBKService {
    typealias ResponseType = SBKGeoTopArtistsResponse
    
    var sbkMethod: SBKMethod = .getTopArtistsInGeo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(country: SBKCountry,
         limit: Int,
         page: Int,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "country", value: country.rawValue),
            .init(name: "page", numericValue: page),
            .init(name: "limit", numericValue: limit)
        ]
    }
}
