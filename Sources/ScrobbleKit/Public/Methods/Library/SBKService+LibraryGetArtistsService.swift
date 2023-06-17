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
    func getLibraryArtists(for user: String, limit: Int = 50, page: Int = 1) async throws -> [SBKArtist] {
        let service = LibraryGetArtistsService(user: user, limit: limit, page: page, apiKey: apiKey, secret: secret)
        let response = try await service.start()
        return response.artists.artist
    }
    
    /**
     Returns a list of all the artists in a user's library.
     
     - Parameters:
        - user: The Last.fm username to fetch the library of.
        - completion: A closure to be executed when the request is complete. It returns an optional array of ``SBKArtist`` objects representing the library and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/library.getArtists).
     */
    func getLibraryArtists(for user: String, limit: Int = 50, page: Int = 1, _ completion: (([SBKArtist]?, Error?) -> Void)?) {
        let service = LibraryGetArtistsService(user: user, limit: limit, page: page, apiKey: apiKey, secret: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.artists.artist, nil)
        }
    }
}
