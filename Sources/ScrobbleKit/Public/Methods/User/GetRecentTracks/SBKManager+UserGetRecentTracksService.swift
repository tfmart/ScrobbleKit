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
     - from: Beginning timestamp of a range in UNIX timestamp format. Default value is nil.
     - extended: Includes extended data in each artist and whether or not the user has loved each track. Default value is nil.
     - to: End timestamp of a range in UNIX timestamp format. Default value is nil.
     
     - Returns: An asynchronous task that returns an ``SBKSearchResult`` object containing the recent tracks.
     
     - Throws: An error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's user.getRecentTracks documentation](https://www.last.fm/api/show/user.getRecentTracks) for more information.
     */
    func getRecentTracks(fromUser user: String, limit: Int = 50, page: Int = 1, from: TimeInterval? = nil, extended: Bool? = nil, to: TimeInterval? = nil) async throws -> SBKSearchResult<SBKScrobbledTrack> {
        let service = UserGetRecentTracksService(
            user: user,
            limit: limit,
            page: page,
            from: from,
            extended: extended,
            to: to,
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
    
    /**
     Get the recent tracks of a user on Last.fm.
     
     - Parameters:
     - user: The username of the user.
     - limit: The number of results to fetch per page. Default value is 50.
     - page: The page number to fetch. Default value is 1.
     - from: Beginning timestamp of a range in UNIX timestamp format. Default value is nil.
     - extended: Includes extended data in each artist and whether or not the user has loved each track. Default value is nil.
     - to: End timestamp of a range in UNIX timestamp format. Default value is nil.
     - completion: The completion handler to call when the request is complete. It returns an ``SBKSearchResult`` object containing the recent tracks, or an error if the operation fails.
     
     - Note: See [Last.fm's user.getRecentTracks documentation](https://www.last.fm/api/show/user.getRecentTracks) for more information.
     */
    func getRecentTracks(fromUser user: String, limit: Int = 50, page: Int = 1, from: TimeInterval? = nil, extended: Bool? = nil, to: TimeInterval? = nil, completion: ((SBKSearchResult<SBKScrobbledTrack>?, Error?) -> Void)?) {
        let service = UserGetRecentTracksService(
            user: user,
            limit: limit,
            page: page,
            from: from,
            extended: extended,
            to: to,
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
            
            let attributes = response.recenttracks.attributes
            guard let page = Int(attributes.page),
                  let perPage = Int(attributes.perPage),
                  let totalPages = Int(attributes.totalPages),
                  let total = Int(attributes.total) else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            
            completion?(.init(results: response.recenttracks.tracks,
                              searchTerms: [.user: attributes.user],
                              page: page,
                              perPage: perPage,
                              totalPages: totalPages,
                              total: total), nil)
        }
    }
}
