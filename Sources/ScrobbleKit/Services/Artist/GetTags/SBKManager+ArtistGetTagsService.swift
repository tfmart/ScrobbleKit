//
//  File.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Asynchronously retrieves the tags applied by an individual user to an artist on Last.fm.
     
     - Parameters:
        - searchMethod: The artist search method, either by name or by MusicBrainz ID.
        - user: The username of the user who applied the tags to the artist. If not provided, all user tags will be returned.
        - autocorrect: A Boolean value indicating whether to correct any misspelled artist names. The default value is `true`.
     
     - Returns: An array of ``SBKTag`` objects representing the tags applied by the user to the artist. If no tags were found, an empty array is returned.
     
     - Throws: An error of type ``SBKClientError`` or an error returned by the Last.fm API.
     
     - Note: See [Last.fm's artist.getTags documentation](https://www.last.fm/api/show/artist.getTags) for more information.
     */
    func getArtistTags(_ searchMethod: SBKArtistSearchMethod,
                       user: String? = nil,
                       autocorrect: Bool) async throws -> [SBKTag] {
        let service = ArtistGetTagsService(
            searchMethod: searchMethod,
            user: user,
            autocorrect: autocorrect,
            apiKey: apiKey,
            secretKey: secret)
        let response = try await service.start()
        return response.tags.tag
    }
    
    /**
     Retrieves the tags applied by an individual user to an artist on Last.fm.
     
     - Parameters:
        - searchMethod: The artist search method, either by name or by MusicBrainz ID.
        - user: The username of the user who applied the tags to the artist. If not provided, all user tags will be returned.
        - autocorrect: A Boolean value indicating whether to correct any misspelled artist names. The default value is `true`.
        - completion: A closure to be called with the result of the operation. The closure takes an optional array of ``SBKTag`` objects and an optional error object as its parameters.
     
     - Throws: An error of type ``SBKClientError`` or an error returned by the Last.fm API.
     
     - Note: See [Last.fm's artist.getTags documentation](https://www.last.fm/api/show/artist.getTags) for more information.
     */
    func getArtistTags(_ searchMethod: SBKArtistSearchMethod,
                       user: String? = nil,
                       autocorrect: Bool,
                       _ completion: (([SBKTag]?, Error?) -> Void)?) {
        let service = ArtistGetTagsService(searchMethod: searchMethod, user: user, autocorrect: autocorrect, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let tags = response?.tags.tag else {
                completion?([], nil)
                return
            }
            completion?(tags, nil)
        }
    }
}
