//
//  SBKManager+AlbumAddTags.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension SBKManager {
    @discardableResult
    func addTags(toAlbum album: String, artist: String, tags: [String]) async throws -> Bool {
        guard let sessionKey else { throw SBKError.missingSessionKey }
        let service = AlbumAddTagsService(
            album: album,
            artist: artist,
            tags: tags,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        _ = try await service.start()
        return true
    }
    
    func addTags(toAlbum album: String, artist: String, tags: [String], _ completion: ((Bool?, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(nil, SBKError.missingSessionKey)
            return
        }
        let service = AlbumAddTagsService(
            album: album,
            artist: artist,
            tags: tags,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response != nil else {
                completion?(nil, SBKError.failedToDecodeResponse)
                return
            }
            completion?(true, nil)
        }
    }
}
