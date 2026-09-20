//
//  SBKManager+UserGetFriendsService.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get friends of a user on Last.fm.
     
     - Parameters:
     - user: The username of the user.
     - recentTracks: Whether to include information about the user's recent tracks. Default value is `false`.
     - limit: The maximum number of friends to retrieve. Default value is 50.
     - page: The page number of the results to retrieve. Default value is 1.
     
     - Returns: An ``SBKSearchResult`` containing the user's friends and pagination metadata reported by Last.fm.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: See [Last.fm's user.getFriends documentation](https://www.last.fm/api/show/user.getFriends) for more information.
     */
    func getFriends(
        for user: String,
        recentTracks: Bool = false,
        limit: Int = .sbkLimitPerPage,
        page: Int = .sbkFirstPage
    ) async throws -> SBKSearchResult<SBKUser> {
        let service = UserGetFriendsService(
            user: user,
            recentTracks: recentTracks,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let attributes = response.friends.attributes else {
            throw SBKClientError.failedToDecodeResponse
        }
        let paginationAttributes = SBKPaginationAttributes(
            page: attributes.page,
            perPage: attributes.perPage,
            totalPages: attributes.totalPages,
            total: attributes.total
        )
        let pagination = try SBKPagination(attributes: paginationAttributes)
        return .init(
            results: response.friends.friends.map { SBKUser(from: $0) },
            searchTerms: [.user: attributes.user ?? user],
            pagination: pagination
        )
    }
}
