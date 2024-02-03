//
//  SBKManager+AristGetInfoService.swift
//
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation


public extension SBKManager {
    /**
     Get the metadata for an artist on Last.fm using the artist name or a MusicBrainz ID.
     
     - Parameters:
     - artist: The search method to use for the artist. The search method can be an artist name or a MusicBrainz ID.
     - autocorrect: Transform misspelled artist or album names into correct names, returning the correct version instead. The corrected artist name will be returned in the response. The default value is `true`.
     - username: The username for the context of the request. If supplied, the user's playcount for this artist is included in the response. The default value is `nil`.
     - language: The language to return the biography in, expressed as an ISO 639 alpha-2 code. The default value is ``SBKLanguageCode.english`.
     
     - Returns: An ``SBKArtist`` object that contains the metadata for the artist.
     
     - Throws: An error of type ``SBKClientError``or ``SBKError`` if the operation fails
     
     - Note: See [Last.fm's artist.getInfo documentation](https://www.last.fm/api/show/artist.getInfo) for more information.
     */
    func getInfo(
        forArtist artist: SBKArtistSearchMethod,
        autocorrect: Bool = true,
        username: String? = nil,
        language: SBKLanguageCode = .english
    ) async throws -> SBKArtist {
        let service = ArtistGetInfoService(
            searchMethod: artist,
            autoCorrect: autocorrect,
            username: username,
            languageCode: language,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return SBKArtist(getInfoData: response)
    }
    
    /**
     Get the metadata for an artist on Last.fm using the artist name or a MusicBrainz ID.
     
     - Parameters:
     - artist: The search method to use for the artist. The search method can be an artist name or a MusicBrainz ID.
     - autocorrect: Transform misspelled artist or album names into correct names, returning the correct version instead. The corrected artist name will be returned in the response. The default value is `true`.
     - username: The username for the context of the request. If supplied, the user's playcount for this artist is included in the response. The default value is `nil`.
     - language: The language to return the biography in, expressed as an ISO 639 alpha-2 code. The default value is ``SBKLanguageCode.english`.
     - completion: The completion handler to call when the operation is complete. The handler takes two arguments: an ``SBKArtist`` object that contains the metadata for the artist, and an error if the operation fails.
     
     - Note: See [Last.fm's artist.getInfo documentation](https://www.last.fm/api/show/artist.getInfo) for more information.
     */
    func getInfo(
        forArtist artist: SBKArtistSearchMethod,
        autocorrect: Bool = true,
        username: String? = nil,
        language: SBKLanguageCode = .english,
        _ completion: ((SBKArtist?, Error?) -> Void)?
    ) {
        let service = ArtistGetInfoService(
            searchMethod: artist,
            autoCorrect: autocorrect,
            username: username,
            languageCode: language,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(SBKArtist(getInfoData: response), error)
        }   
    }
}
