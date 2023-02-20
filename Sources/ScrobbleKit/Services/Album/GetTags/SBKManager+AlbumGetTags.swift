//
//  SBKManager+AlbumGetTags.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension SBKManager {
    /**
     Gets the tags applied by an individual user to an album on Last.fm.
     
     To retrieve the list of tags applied to an album by all users use ``getTopTags(forAlbum:autoCorrect:)``

     - Parameters:
        - searchMethod: The album search method, either by name or by a MusicBrainz ID.
        - autoCorrect: A Boolean value indicating whether to transform misspelled artist names into correct artist names. The default value is `true`.
        - username: The username for the context of the request. If supplied, the tags of this album applied by the user are included in the response.
     
     - Returns: An array of ``SBKTag`` objects representing the tags applied by the user to the album.
     
     - Throws: An error of type ``SBKClientError``or ``SBKError`` if the operation fails
     
     - Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.getTags) for more information.
     */
    public func getTags(
        forAlbum searchMethod: SBKAlbumSearchMethod,
        autoCorrect: Bool = true,
        username: String? = nil
    ) async throws -> [SBKTag] {
        let service = AlbumGetTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            username: username,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.tags.tag
    }
    
    /**
     Gets the tags applied by an individual user to an album on Last.fm.
     
     To retrieve the list of tags applied to an album by all users use ``getTopTags(forAlbum:autoCorrect:_:)``
     
     - Parameters:
        - searchMethod: The album search method, either by name or by MusicBrainz ID.
        - autoCorrect: A Boolean value indicating whether to transform misspelled artist names into correct artist names. The default value is `true`.
        - username: The username for the context of the request. If supplied, the tags of this album applied by the user are included in the response.
        - completion: A closure to be called with the result of the operation. The closure takes an optional array of ``SBKTag`` objects and an optional error object as its parameters.
     
     - Throws: An error of type ``SBKClientError``or ``SBKError`` if the operation fails
     
     - Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.getTags) for more information.
     */
    public func getTags(forAlbum searchMethod: SBKAlbumSearchMethod,
                 autoCorrect: Bool = true,
                 username: String? = nil,
                 _ completion: (([SBKTag]?, Error?) -> Void)?
    ) {
        let service = AlbumGetTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            username: username,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let tags = response?.tags.tag else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(tags, nil)
        }
    }
}
