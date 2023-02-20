//
//  ArtistGetCorrectionService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct ArtistGetCorrectionService: SBKService {
    typealias ResponseType = String
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getCorrectedArtistInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(artist: String, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [.init(name: "artist", value: artist)]
    }
}
