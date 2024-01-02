//
//  SBKManager+ChartGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Gets a list of the top tracks on Last.fm ordered by popularity.
     
     - Parameters:
     - limit: The maximum number of tracks to return. Maximum value is 1000.
     - page: The page number to fetch. Defaults to first page (page 1).
     
     - Returns: An array of ``SBKTrack`` objects representing the top tracks.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopTracks).
     */
    func getTracksChart(limit: Int = 50, page: Int = 1) async throws -> [SBKTrack] {
        let service = ChartGetTopTracksService(limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.tracks.track
    }
    
    /**
     Gets a list of the top tracks on Last.fm ordered by popularity.
     
     - Parameters:
     - limit: The maximum number of tracks to return. Maximum value is 1000.
     - page: The page number to fetch. Defaults to first page (page 1).
     - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKTrack`` objects representing the top tracks and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopTracks).
     */
    func getTracksChart(limit: Int = 50, page: Int = 1, _ completion: (([SBKTrack]?, Error?) -> Void)?) {
        let service = ChartGetTopTracksService(limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response != nil else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response?.tracks.track, nil)
        }
    }
}


