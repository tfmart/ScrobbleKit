//
//  SBKManager+AlbumGetInfo.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the metadata and tracklist for an album on Last.fm using the album name or a MusicBrainz ID.

     - Parameters:
        - searchMethod: The search method to use for the album. The search method can be an album name or a MusicBrainz ID.
        - autoCorrect: Transform misspelled artist or album names into correct names, returning the correct version instead. The corrected artist name will be returned in the response. The default value is `true`.
        - username: The username for the context of the request. If supplied, the user's playcount for this album is included in the response. The default value is `nil`.
        - languageCode: The language to return the biography in, expressed as an ISO 639 alpha-2 code. The default value is ``SBKLanguageCode.english``.
     
     - Returns: An ``SBKAlbumResponse`` object that contains the metadata and tracklist for the album.
     
     - Throws: An error of type ``SBKClientError``or ``SBKError`` if the operation fails
     
     - Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.getInfo) for more information.
     */
    func getInfo(forAlbum searchMethod: SBKAlbumSearchMethod,
                 autoCorrect: Bool = true,
                 username: String? = nil,
                 languageCode: SBKLanguageCode = .english
    ) async throws -> SBKAlbumResponse {
        let service = AlbumGetInfoService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            username: username,
            languageCode: languageCode,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return .init(response: response)
    }
    
    /**
     Get the metadata and tracklist for an album on Last.fm using the album name or a MusicBrainz ID.

     - Parameters:
        - searchMethod: The search method to use for the album. The search method can be an album name or a MusicBrainz ID.
        - autoCorrect: Transform misspelled artist or album names into correct names, returning the correct version instead. The corrected artist name will be returned in the response. The default value is `true`.
        - username: The username for the context of the request. If supplied, the user's playcount for this album is included in the response. The default value is `nil`.
        - languageCode: The language to return the biography in, expressed as an ISO 639 alpha-2 code. The default value is ``SBKLanguageCode.english``.
        - completion: The completion handler to call when the operation is complete. The handler takes two arguments: an ``SBKAlbumResponse`` object that contains the metadata and tracklist for the album, and an error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.getInfo) for more information.
     */
    func getInfo(forAlbum searchMethod: SBKAlbumSearchMethod,
                 autoCorrect: Bool = true,
                 username: String? = nil,
                 languageCode: SBKLanguageCode = .english,
                 _ completion: ((SBKAlbumResponse?, Error?) -> Void)?
    ) {
        let service = AlbumGetInfoService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            username: username,
            languageCode: languageCode,
            apiKey: apiKey,
            secretKey: secret
        )
        
        service.start { album, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let album else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(.init(response: album), nil)
        }
    }
}
