//
//  SBKManager+UserGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the top tracks of a user on Last.fm asynchronously.
     
     - Parameters:
     - user: The username of the user.
     - period: The time period over which to retrieve top tracks for. Possible values: overall, 7day, 1month, 3month, 6month, 12month. Default value is `overall`.
     - limit: The number of results to fetch per page. Default value is `50`.
     - page: The page number to fetch. Default value is `1`.
     
     - Returns: An asynchronous task that returns a ``SBKSearchResult`` object with a list of ``SBKTrack``
     
     - Throws: An error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's user.getTopTracks documentation](https://www.last.fm/api/show/user.getTopTracks) for more information.
     */
    func getTopTracks(forUser user: String, period: SBKSearchPeriod = .overall, limit: Int = 50, page: Int = 1) async throws -> SBKSearchResult<SBKTrack> {
        let service = UserGetTopTracksService(
            user: user,
            period: period.rawValue,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.topTracks.attributes
        guard let page = Int(attributes.page),
              let perPage = Int(attributes.perPage),
              let totalPages = Int(attributes.totalPages),
              let total = Int(attributes.total) else {
            throw SBKClientError.failedToDecodeResponse
        }
        
        return .init(results: response.topTracks.tracks,
                     searchTerms: [.user: attributes.user],
                     page: page,
                     perPage: perPage,
                     totalPages: totalPages,
                     total: total)
    }
    
    /**
     Get the top tracks of a user on Last.fm.
     
     - Parameters:
     - user: The username of the user.
     - period: The time period over which to retrieve top tracks for. Possible values: overall, 7day, 1month, 3month, 6month, 12month. Default value is `overall`.
     - limit: The number of results to fetch per page. Default value is `50`.
     - page: The page number to fetch. Default value is `1`.
     - completion: The completion handler to call when the request is complete. It returns a ``SBKSearchResult`` object with a list of ``SBKTrack`` and an optional `Error`.
     
     - Note: See [Last.fm's user.getTopTracks documentation](https://www.last.fm/api/show/user.getTopTracks) for more information.
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func getTopTracks(forUser user: String, period: SBKSearchPeriod = .overall, limit: Int = 50, page: Int = 1, completion: ((SBKSearchResult<SBKTrack>?, Error?) -> Void)?) {
        let service = UserGetTopTracksService(
            user: user,
            period: period.rawValue,
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
            let attributes = response.topTracks.attributes
            guard let page = Int(attributes.page),
                  let perPage = Int(attributes.perPage),
                  let totalPages = Int(attributes.totalPages),
                  let total = Int(attributes.total) else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            
            completion?(.init(results: response.topTracks.tracks,
                              searchTerms: [.user: attributes.user],
                              page: page,
                              perPage: perPage,
                              totalPages: totalPages,
                              total: total), nil)
        }
    }
}
