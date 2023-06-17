//
//  SBKManager+ChartGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Gets the top tags for the last week.
     
     - Parameters:
     - limit: The maximum number of tags to return per page.
     
     - Returns: An array of ``SBKTag`` objects representing the top tags.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopTags).
     */
    func getTopTags(page: Int = 1, limit: Int = 50) async throws -> [SBKTag] {
        let service = ChartGetTopTagsService(page: page, limit: limit, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        guard let tags = response.toptags.tag else {
            return []
        }
        return tags
    }
    
    /**
     Gets the top tags for the last week.
     
     - Parameters:
     - limit: The maximum number of tags to return per page.
     - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKTag`` objects representing the top tags and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopTags).
     */
    func getTopTags(page: Int = 1, limit: Int = 50, _ completion: (([SBKTag]?, Error?) -> Void)?) {
        let service = ChartGetTopTagsService(page: page, limit: limit, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response != nil else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response?.toptags.tag, nil)
        }
    }
}


