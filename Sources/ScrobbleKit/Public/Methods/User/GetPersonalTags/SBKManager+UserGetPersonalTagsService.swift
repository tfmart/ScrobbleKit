//
//  SBKManager+UserGetPersonalTagsService.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

public extension SBKManager {
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
}
