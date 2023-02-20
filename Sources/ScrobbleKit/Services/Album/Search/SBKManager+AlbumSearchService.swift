//
//  SBKManager+AlbumSearchService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

extension SBKManager {
    func search(
        album: String,
        page: Int = 1,
        limit: Int = 50
    ) async throws -> [SBKAlbum] {
        let service = AlbumSearchService(album: album, limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        guard let albumList = response.results.albumMatches?.album else {
            throw SBKClientError.failedToDecodeResponse
        }
        return albumList
        
    }
    
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
            completion?(response?.results.albumMatches?.album, nil)
        }
    }
}
