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
     
     - Returns: An asynchronous task that returns an array of friend usernames.
     
     - Throws: An error of type `SBKError` if the operation fails.
     
     - Note: See [Last.fm's user.getFriends documentation](https://www.last.fm/api/show/user.getFriends) for more information.
     */
    func getFriends(for user: String, recentTracks: Bool = false, limit: Int = 50, page: Int = 1) async throws -> [SBKUser] {
        let service = UserGetFriendsService(
            user: user,
            recentTracks: recentTracks,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let responseList = response.friends.friends
        return responseList.map { SBKUser(from: $0)}
    }
    
    /**
     Get friends of a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - recentTracks: Whether to include information about the user's recent tracks. Default value is `false`.
       - limit: The maximum number of friends to retrieve. Default value is 50.
       - page: The page number of the results to retrieve. Default value is 1.
       - completion: The completion handler to call when the request is complete. It returns an array of friend usernames and an optional error.
     
     - Note: See [Last.fm's user.getFriends documentation](https://www.last.fm/api/show/user.getFriends) for more information.
     */
    func getFriends(for user: String, recentTracks: Bool = false, limit: Int = 50, page: Int = 1, completion: (([SBKUser]?, Error?) -> Void)?) {
        let service = UserGetFriendsService(
            user: user,
            recentTracks: recentTracks,
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
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            
            let responseList = response.friends.friends
            completion?(responseList.map { SBKUser(from: $0)}, nil)
        }
    }
}
