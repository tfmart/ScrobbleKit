//
//  SBKManager+UserGetInfoService.swift
//  
//
//  Created by Tomas Martins on 25/04/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves information about a Last.fm user.
     
     - Parameters:
        - username: The username of the user to retrieve information for.
        - completion: A closure to be executed when the request is complete. It returns an optional ``SBKUserInfo`` object representing the user information and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/user.getInfo).
     */
    func getUserInfo(
        for username: String? = nil,
        _ completion: ((SBKUser?, Error?) -> Void)?
    ) {
        let service = UserGetInfoService(username: username, apiKey: apiKey, secretKey: secret, sessionKey: sessionKey)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            let user = SBKUser(from: response.user)
            completion?(user, nil)
        }
    }
    
    /**
     Retrieves information about a Last.fm user.
     
     - Parameters:
        - username: The username of the user to retrieve information for.
     
     - Returns: A ``SBKUserInfo`` object representing the user information.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/user.getInfo).
     */
    func getUserInfo(for username: String? = nil) async throws -> SBKUser {
        let service = UserGetInfoService(username: username, apiKey: apiKey, secretKey: secret, sessionKey: sessionKey)
        let response = try await service.start()
        let user = SBKUser(from: response.user)
        return user
    }
}
