//
//  File.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the top albums of a user on Last.fm.
     
     - Parameters:
     - user: The username of the user.
     - period: The time period over which to retrieve top albums for. Possible values: overall, 7day, 1month, 3month, 6month, 12month. Default value is ``SBKSearchPeriod.overall``.
     - limit: The number of results to fetch per page. Default value is 50.
     - page: The page number to fetch. Default value is 1.
     
     - Returns: An asynchronous task that returns an ``SBKSearchResult`` object containing the top albums.
     
     - Throws: An error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's user.getTopAlbums documentation](https://www.last.fm/api/show/user.getTopAlbums) for more information.
     */
    func getTopAlbums(forUser user: String, period: SBKSearchPeriod = .overall, limit: Int = 50, page: Int = 1) async throws -> SBKSearchResult<SBKAlbum> {
        let service = UserGetTopAlbumsService(
            user: user,
            period: period.rawValue,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.topAlbums.attributes
        guard let page = Int(attributes.page),
              let perPage = Int(attributes.perPage),
              let totalPages = Int(attributes.totalPages),
              let total = Int(attributes.total) else {
            throw SBKClientError.failedToDecodeResponse
        }
        
        return .init(results: response.topAlbums.albums,
                     searchTerms: [.user: attributes.user],
                     page: page,
                     perPage: perPage,
                     totalPages: totalPages,
                     total: total)
    }
    
    /**
     Get the top albums of a user on Last.fm.
     
     - Parameters:
     - user: The username of the user.
     - period: The time period over which to retrieve top albums for. Possible values: overall, 7day, 1month, 3month, 6month, 12month. Default value is ``SBKSearchPeriod.overall``.
     - limit: The number of results to fetch per page. Default value is 50.
     - page: The page number to fetch. Default value is 1.
     - completion: The completion handler to call when the request is complete. It returns an ``SBKSearchResult`` object containing the top albums, or an optional error.
     
     - Note: See [Last.fm's user.getTopAlbums documentation](https://www.last.fm/api/show/user.getTopAlbums) for more information.
     */
    func getUserTopAlbums(forUser user: String, period: SBKSearchPeriod = .overall, limit: Int = 50, page: Int = 1, completion: ((SBKSearchResult<SBKAlbum>?, Error?) -> Void)?) {
        let service = UserGetTopAlbumsService(
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
            
            let attributes = response.topAlbums.attributes
            guard let page = Int(attributes.page),
                  let perPage = Int(attributes.perPage),
                  let totalPages = Int(attributes.totalPages),
                  let total = Int(attributes.total) else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            
            completion?(.init(results: response.topAlbums.albums,
                              searchTerms: [.user: attributes.user],
                              page: page,
                              perPage: perPage,
                              totalPages: totalPages,
                              total: total), nil)
        }
    }
}
