//
//  SBKManager+AlbumGetTopTags.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

extension SBKManager {
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
        return response.toptags.tag
    }
    
    func getTopTags(forAlbum searchMethod: SBKAlbumSearchMethod,
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
