//
//  SBKManager+UserGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the top tags of a user on Last.fm asynchronously.
     
     - Parameters:
     - user: The username of the user.
     - limit: Limit the number of tags returned. Default value is `nil`.
     
     - Returns: An asynchronous task that returns an ``SBKSearchResult`` object containing an array of ``SBKTag`` objects.
     
     - Throws: An error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's user.getTopTags documentation](https://www.last.fm/api/show/user.getTopTags) for more information.
     */
    func getTopTags(forUser user: String, limit: Int? = nil) async throws -> SBKSearchResult<SBKTag> {
        let service = UserGetTopTagsService(
            user: user,
            limit: limit,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.topTags.attributes
        
        return .init(results: response.topTags.tags,
                     searchTerms: [.user: attributes.user],
                     page: 1,
                     perPage: limit ?? response.topTags.tags.count,
                     totalPages: 1,
                     total: response.topTags.tags.count)
    }
}
