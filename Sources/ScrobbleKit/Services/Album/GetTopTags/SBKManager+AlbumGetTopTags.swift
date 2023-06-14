//
//  SBKManager+AlbumGetTopTags.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

extension SBKManager {
    /**
    Fetches the top tags for an album on Last.fm, ordered by popularity.
     
     - Parameters:
        - searchMethod: The search method for the album, either by album name and artist name or by MusicBrainz ID..
        - autoCorrect: Whether to transform misspelled artist names into correct artist names, returning the correct version instead. The corrected artist name will be returned in the response. The default value is `true`.
     
     - Returns: An array of ``SBKTag`` objects representing the top tags for the specified album.
     
     - Throws: An error of type ``SBKClientError``or ``SBKError`` if the operation fails
     -  Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.getTopTags) for more information.
    */
    public func getTopTags(
        forAlbum searchMethod: SBKAlbumSearchMethod,
        autoCorrect: Bool = true
    ) async throws -> [SBKTag] {
        let service = AlbumGetTopTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let tags = response.toptags.tag else {
            return []
        }
        return tags
    }
    
    /**
    Fetches the top tags for an album on Last.fm, ordered by popularity.
     
     - Parameters:
        - searchMethod: The search method for the album, either by album name and artist name or by MusicBrainz ID..
        - autoCorrect: Whether to transform misspelled artist names into correct artist names, returning the correct version instead. The corrected artist name will be returned in the response. The default value is `true`.
        - completion: The closure to be called with the array of ``SBKTag`` objects representing the top tags for the specified album, or an error if the operation fails.
     
     -  Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.getTopTags) for more information.
    */
    public func getTopTags(forAlbum searchMethod: SBKAlbumSearchMethod,
                 autoCorrect: Bool = true,
                 _ completion: (([SBKTag]?, Error?) -> Void)?
    ) {
        let service = AlbumGetTopTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let tags = response?.toptags.tag else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(tags, nil)
        }
    }
}
