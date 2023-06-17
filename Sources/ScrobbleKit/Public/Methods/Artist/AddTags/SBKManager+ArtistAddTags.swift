//
//  SBKManager+AddTagsService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public extension SBKManager {
    @discardableResult
    func addTags(toArtist artist: String, tags: [String]) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = AddTagsService(to: .artist(artist),
                                     tags: tags,
                                     apiKey: apiKey,
                                     secretKey: secret,
                                     sessionKey: sessionKey)
        _ = try await service.start()
        return true
    }
    
    func addTags(toArtist artist: String, tags: [String], _ completion: ((Bool?, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(nil, SBKClientError.missingSessionKey)
            return
        }
        let service = AddTagsService(to: .artist(artist),
                                     tags: tags,
                                     apiKey: apiKey,
                                     secretKey: secret,
                                     sessionKey: sessionKey)
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
