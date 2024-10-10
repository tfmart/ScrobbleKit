//
//  SBKManager+ArtistGetTopAlbums.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Gets the top albums for the specified artist.
     
     - Parameters:
     - searchMethod: The search method to use to find the artist. Either by name or MusicBrainz ID.
     - limit: The maximum number of albums to return. Default is 50.
     - page: The page of results to return. Default is 1.
     
     - Returns: An array of ``SBKAlbum`` objects representing the artist's top albums.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getTopAlbums).
     */
    func getTopAlbums(
        forArtist searchMethod: SBKArtistSearchMethod,
        limit: Int = 50,
        page: Int = 1,
        autoCorrect: Bool = true
    ) async throws -> [SBKAlbum] {
        let service = ArtistGetTopAlbumsService(
            searchMethod,
            limit: limit,
            page: page,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.topAlbums.albums.map({ SBKAlbum(topAlbumArtist: $0) })
    }
    
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func getTopAlbums(
        forArtist searchMethod: SBKArtistSearchMethod,
        limit: Int = 50,
        page: Int = 1,
        autoCorrect: Bool = true,
        _ completion: (([SBKAlbum]?, Error?) -> Void)?
    ) {
        let service = ArtistGetTopAlbumsService(
            searchMethod,
            limit: limit,
            page: page,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let albums = response?.topAlbums.albums else {
                completion?([], nil)
                return
            }
            let albumList = albums.map({ SBKAlbum(topAlbumArtist: $0) })
            completion?(albumList, nil)
        }
    }
}
