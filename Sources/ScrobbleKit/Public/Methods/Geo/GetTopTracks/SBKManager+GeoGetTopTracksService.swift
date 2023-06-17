//
//  SBKManager+GeoGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 24/02/23.
//

import Foundation

public extension SBKManager {
    func getTopTracks(
        forCountry country: SBKCountry,
        limit: Int = 50,
        page: Int = 1
    ) async throws -> [SBKTrack] {
        let service = GeoGetTopTracksService(
            country: country,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.tracks.track
    }
    
    func getTopTracks(
        forCountry country: SBKCountry,
        limit: Int = 50,
        page: Int = 1,
        completion: (([SBKTrack]?, Error?) -> Void)?
    ) {
        let service = GeoGetTopTracksService(
            country: country,
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
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.tracks.track, nil)
        }
    }
}
