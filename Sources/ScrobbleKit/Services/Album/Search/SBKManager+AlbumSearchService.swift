//
//  SBKManager+AlbumSearchService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Searches for an album by name. Returns album matches sorted by relevance.

     - Parameters:
        - album: The album name to search for.
        - page: The page number to fetch. Defaults to 1.
        - limit: The number of results to fetch per page. Defaults to 50.
     
     - Returns: An array of ``SBKAlbum`` objects representing the search results.

     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/album.search).
     */
    func search(
        album: String,
        page: Int = 1,
        limit: Int = 50
    ) async throws -> [SBKAlbum] {
        let service = AlbumSearchService(album: album, limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        guard let albumList = response.results.matches.album else {
            throw SBKClientError.failedToDecodeResponse
        }
        return albumList
        
    }
    
    /**
     Searches for an album by name. Returns album matches sorted by relevance.

     - Parameters:
        - album: The album name to search for.
        - page: The page number to fetch. Defaults to 1.
        - limit: The number of results to fetch per page. Defaults to 50.
        - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKAlbum`` objects representing the search results and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/album.search).
     */
    func search(
        album: String,
        page: Int = 1,
        limit: Int = 50,
        _ completion: (([SBKAlbum]?, Error?) -> Void)?
    ) {
        let service = AlbumSearchService(album: album, limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response != nil else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response?.results.matches.album, nil)
        }
    }
}
