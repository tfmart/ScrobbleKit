//
//  SBKManager+UserGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the top tags of a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - limit: Limit the number of tags returned. Default value is nil.
     
     - Returns: An asynchronous task that returns a string.
     
     - Throws: An error of type `SBKError` if the operation fails.
     
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
    
    /**
     Get the top tags of a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - limit: Limit the number of tags returned. Default value is nil.
       - completion: The completion handler to call when the request is complete. It returns a string and an optional error.
     
     - Note: See [Last.fm's user.getTopTags documentation](https://www.last.fm/api/show/user.getTopTags) for more information.
     */
    func getTopTags(forUser user: String, limit: Int? = nil, completion: ((SBKSearchResult<SBKTag>?, Error?) -> Void)?) {
        let service = UserGetTopTagsService(
            user: user,
            limit: limit,
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
            
            let attributes = response.topTags.attributes
            
            completion?(.init(results: response.topTags.tags,
                              searchTerms: [.user: attributes.user],
                              page: 1,
                              perPage: limit ?? response.topTags.tags.count,
                              totalPages: 1,
                              total: response.topTags.tags.count), nil)
        }
    }
}
