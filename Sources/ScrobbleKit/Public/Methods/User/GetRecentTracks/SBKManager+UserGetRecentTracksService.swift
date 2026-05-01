//
//  SBKManager+GetRecentTracksService.swift
//
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the recent tracks of a user on Last.fm.
     
     - Parameters:
     - user: The username of the user.
     - limit: The number of results to fetch per page. Default value is 50.
     - page: The page number to fetch. Default value is 1.
     - startDate: The start date of the range for which to retrieve tracks. Default value is nil.
     - extended: Includes extended data in each artist, and whether or not the user has loved each track. Default value is false.
     - endDate: The end date of the range for which to retrieve tracks. Default value is nil.
     
     - Returns: An asynchronous task that returns an ``SBKSearchResult`` object containing the recent tracks.
     
     - Throws: An error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's user.getRecentTracks documentation](https://www.last.fm/api/show/user.getRecentTracks) for more information.
     */
    func getRecentTracks(
        fromUser user: String,
        limit: Int = .sbkLimitPerPage,
        page: Int = .sbkFirstPage,
        startDate: Date? = nil,
        extended: Bool = false,
        endDate: Date? = nil
    ) async throws -> SBKSearchResult<SBKScrobbledTrack> {
        let service = UserGetRecentTracksService(
            user: user,
            limit: limit,
            page: page,
            from: startDate,
            extended: extended,
            to: endDate,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.recenttracks.attributes
        guard let page = Int(attributes.page),
              let perPage = Int(attributes.perPage),
              let totalPages = Int(attributes.totalPages),
              let total = Int(attributes.total) else {
            throw SBKClientError.failedToDecodeResponse
        }
        
        return .init(results: response.recenttracks.tracks,
                     searchTerms: [.user: attributes.user],
                     page: page,
                     perPage: perPage,
                     totalPages: totalPages,
                     total: total)
    }
}
