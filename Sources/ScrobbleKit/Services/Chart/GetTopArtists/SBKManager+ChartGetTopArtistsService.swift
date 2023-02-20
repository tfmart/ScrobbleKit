//
//  SBKManager+ChartGetTopArtistsService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public extension SBKManager {
    func getTopArtistsChart(
        page: Int = 1,
        limit: Int = 50
    ) async throws -> [SBKArtist] {
        let service = ChartGetTopArtistsService(
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.artists.artists
    }
    
    func getTopArtistsChart(
        page: Int = 1,
        limit: Int = 50,
        _ completion: (([SBKArtist]?, Error?) -> Void)?
    ) {
        let service = ChartGetTopArtistsService(
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.artists.artists, nil)
        }
    }
}
