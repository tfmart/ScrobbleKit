//
//  SBKManager+UserGetPersonalTagsService.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Get personal tags for artists from a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - tag: The tag you're interested in.
       - limit: The number of results to fetch per page. Defaults to 50.
       - page: The page number to fetch. Defaults to first page.
     
     - Returns: An asynchronous task that returns an ``SBKSearchResult`` containing an array of ``SBKArtist`` objects.
     
     - Throws: An error of type ``SBKError` if the operation fails.
     
     - Note: See [Last.fm's user.getPersonalTags documentation](https://www.last.fm/api/show/user.getPersonalTags) for more information.
     */
    func getPersonalTagsForArtists(fromUser user: String, tag: String, limit: Int = 50, page: Int = 1) async throws -> SBKSearchResult<SBKArtist> {
        let service = UserGetPersonalTagsService(
            user: user,
            tag: tag,
            taggingType: "artist",
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.taggings.attributes
        guard let page = Int(attributes.page),
              let perPage = Int(attributes.perPage),
              let totalPages = Int(attributes.totalPages),
              let total = Int(attributes.total),
              let artists = response.taggings.artists?.artist else {
            throw SBKClientError.failedToDecodeResponse
        }
        
        return .init(results: artists,
                     searchTerms: [.user:  attributes.user, .tag: attributes.tag],
                     page: page,
                     perPage: perPage,
                     totalPages: totalPages,
                     total: total)
    }
    
    /**
     Get personal tags for tracks from a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - tag: The tag you're interested in.
       - limit: The number of results to fetch per page. Defaults to 50.
       - page: The page number to fetch. Defaults to first page.
     
     - Returns: An asynchronous task that returns an ``SBKSearchResult`` containing an array of ``SBKTrack`` objects.
     
     - Throws: An error of type ``SBKError`` if the operation fails.
     
     - Note: See [Last.fm's user.getPersonalTags documentation](https://www.last.fm/api/show/user.getPersonalTags) for more information.
     */
    func getPersonalTagsForTracks(fromUser user: String, tag: String, limit: Int = 50, page: Int = 1) async throws -> SBKSearchResult<SBKTrack> {
        let service = UserGetPersonalTagsService(
            user: user,
            tag: tag,
            taggingType: "track",
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.taggings.attributes
        guard let page = Int(attributes.page),
              let perPage = Int(attributes.perPage),
              let totalPages = Int(attributes.totalPages),
              let total = Int(attributes.total),
              let tracks = response.taggings.tracks?.track else {
            throw SBKClientError.failedToDecodeResponse
        }
        
        return .init(results: tracks,
                     searchTerms: [.user:  attributes.user, .tag: attributes.tag],
                     page: page,
                     perPage: perPage,
                     totalPages: totalPages,
                     total: total)
    }
    
    /**
     Get personal tags for albums from a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - tag: The tag you're interested in.
       - limit: The number of results to fetch per page. Defaults to 50.
       - page: The page number to fetch. Defaults to first page.
     
     - Returns: An asynchronous task that returns an `SBKSearchResult` containing an array of `SBKAlbum` objects.
     
     - Throws: An error of type `SBKError` if the operation fails.
     
     - Note: See [Last.fm's user.getPersonalTags documentation](https://www.last.fm/api/show/user.getPersonalTags) for more information.
     */
    func getPersonalTagsForAlbums(fromUser user: String, tag: String, limit: Int = 50, page: Int = 1) async throws -> SBKSearchResult<SBKAlbum> {
        let service = UserGetPersonalTagsService(
            user: user,
            tag: tag,
            taggingType: "album",
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let attributes = response.taggings.attributes
        guard let page = Int(attributes.page),
              let perPage = Int(attributes.perPage),
              let totalPages = Int(attributes.totalPages),
              let total = Int(attributes.total),
              let albums = response.taggings.albums?.album else {
            throw SBKClientError.failedToDecodeResponse
        }
        
        return .init(results: albums,
                     searchTerms: [.user:  attributes.user, .tag: attributes.tag],
                     page: page,
                     perPage: perPage,
                     totalPages: totalPages,
                     total: total)
    }
    
    /**
     Get personal tags for artists from a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - tag: The tag you're interested in.
       - limit: The number of results to fetch per page. Defaults to 50.
       - page: The page number to fetch. Defaults to first page.
       - completion: The completion handler to call when the request is complete. It returns an `SBKSearchResult` containing an array of `SBKArtist` objects and an optional error.
     
     - Note: See [Last.fm's user.getPersonalTags documentation](https://www.last.fm/api/show/user.getPersonalTags) for more information.
     */
    func getPersonalTagsForArtists(fromUser user: String, tag: String, limit: Int = 50, page: Int = 1, completion: ((SBKSearchResult<SBKArtist>?, Error?) -> Void)?) {
        Task {
            do {
                let result = try await getPersonalTagsForArtists(fromUser: user, tag: tag, limit: limit, page: page)
                completion?(result, nil)
            } catch {
                completion?(nil, error)
            }
        }
    }
    
    /**
     Get personal tags for tracks from a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - tag: The tag you're interested in.
       - limit: The number of results to fetch per page. Defaults to 50.
       - page: The page number to fetch. Defaults to first page.
       - completion: The completion handler to call when the request is complete. It returns an `SBKSearchResult` containing an array of `SBKTrack` objects and an optional error.
     
     - Note: See [Last.fm's user.getPersonalTags documentation](https://www.last.fm/api/show/user.getPersonalTags) for more information.
     */
    func getPersonalTagsForTracks(fromUser user: String, tag: String, limit: Int = 50, page: Int = 1, completion: ((SBKSearchResult<SBKTrack>?, Error?) -> Void)?) {
        Task {
            do {
                let result = try await getPersonalTagsForTracks(fromUser: user, tag: tag, limit: limit, page: page)
                completion?(result, nil)
            } catch {
                completion?(nil, error)
            }
        }
    }
    
    /**
     Get personal tags for albums from a user on Last.fm.
     
     - Parameters:
       - user: The username of the user.
       - tag: The tag you're interested in.
       - limit: The number of results to fetch per page. Defaults to 50.
       - page: The page number to fetch. Defaults to first page.
       - completion: The completion handler to call when the request is complete. It returns an `SBKSearchResult` containing an array of `SBKAlbum` objects and an optional error.
     
     - Note: See [Last.fm's user.getPersonalTags documentation](https://www.last.fm/api/show/user.getPersonalTags) for more information.
     */
    func getPersonalTagsForAlbums(fromUser user: String, tag: String, limit: Int = 50, page: Int = 1, completion: ((SBKSearchResult<SBKAlbum>?, Error?) -> Void)?) {
        Task {
            do {
                let result = try await getPersonalTagsForAlbums(fromUser: user, tag: tag, limit: limit, page: page)
                completion?(result, nil)
            } catch {
                completion?(nil, error)
            }
        }
    }
}
