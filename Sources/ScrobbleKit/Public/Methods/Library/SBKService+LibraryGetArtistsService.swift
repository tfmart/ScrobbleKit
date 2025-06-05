//
//  SBKService+LibraryGetArtistsService.swift
//  
//
//  Created by Tomas Martins on 24/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Returns a list of all the artists in a user's library.
     
     - Parameters:
        - user: The Last.fm username to fetch the library of.
     
     - Returns: An array of ``SBKArtist`` objects representing the library.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/library.getArtists).
     */
    func getArtistsFromLibrary(from user: String, limit: Int = 50, page: Int = 1) async throws -> [SBKArtist] {
        let service = LibraryGetArtistsService(user: user, limit: limit, page: page, apiKey: apiKey, secret: secret)
        let response = try await service.start()
        return response.artists.artist
    }
}
