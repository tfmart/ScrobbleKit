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
     
     - Returns: A ``SBKUser`` object representing the user information.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/user.getInfo).
     */
    func getInfo(forUser username: String? = nil) async throws -> SBKUser {
        let service = UserGetInfoService(username: username, apiKey: apiKey, secretKey: secret, sessionKey: sessionKey)
        let response = try await service.start()
        let user = SBKUser(from: response.user)
        return user
    }
}
