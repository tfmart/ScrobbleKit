//
//  SBKManager+AlbumGetTags.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension SBKManager {
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
    
    func getTags(forAlbum searchMethod: SBKAlbumSearchMethod,
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
