//
//  SBKManager+ArtistRemoveTagService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {

    func removeTag(fromArtist artist: String, tag: String) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = RemoveTagService(
            to: .artist(artist),
            tag: tag,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        _ = try await service.start()
        return true
    }
    
    func removeTag(fromArtist artist: String, tag: String, _ completion: ((Bool, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(false, SBKClientError.missingSessionKey)
            return
        }
        let service = RemoveTagService(
            to: .artist(artist),
            tag: tag,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        service.start { response, error in
            guard error == nil else {
                completion?(false, error)
                return
            }
            guard response != nil else {
                completion?(false, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(true, nil)
        }
    }
}

