//
//  SBKManager+AlbumRemoveTagService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

extension SBKManager {
    func removeTag(fromAlbum album: String, artist: String, tag: String) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = AlbumRemoveTagService(
            album: album,
            artist: artist,
            tag: tag,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        _ = try await service.start()
        return true
    }
    
    func removeTag(fromAlbum album: String, artist: String, tag: String, _ completion: ((Bool?, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(nil, SBKClientError.missingSessionKey)
            return
        }
        let service = AlbumRemoveTagService(
            album: album,
            artist: artist,
            tag: tag,
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
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(true, nil)
        }
    }
}
