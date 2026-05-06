//
//  SBKManager+UserGetLovedTracksService.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the loved tracks of a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - limit: The maximum number of loved tracks to retrieve. Default value is 50.
       - page: The page number of the results to retrieve. Default value is 1.
     
     - Returns: An asynchronous task that returns an instance of ``SBKLovedTracks``
     
     - Throws: An error of type `SBKError` if the operation fails.
     
     - Note: See [Last.fm's user.getLovedTracks documentation](https://www.last.fm/api/show/user.getLovedTracks) for more information.
     */
    @discardableResult
    func getLovedTracks(fromUser user: String, limit: Int = .sbkLimitPerPage, page: Int = .sbkFirstPage) async throws -> SBKLovedTracks {
        let service = UserGetLovedTracksService(
            user: user,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        return SBKLovedTracks(from: response)
    }
}
