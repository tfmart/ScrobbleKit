//
//  SBKManager+AddTagsService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public extension SBKManager {
    /// Adds tags to an artist asynchronously.
    ///
    /// - Parameters:
    ///   - artist: The name of the artist to add tags to.
    ///   - tags: An array of tags to be added.
    /// - Returns: A boolean value indicating whether the operation was successful.
    /// - Throws: ``SBKClientError`` if the operation fails, or an error returned by the Last.fm
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
    
    /// Adds tags to an artist.
    ///
    /// - Parameters:
    ///   - artist: The name of the artist to add tags to.
    ///   - tags: An array of tags to be added.
    ///   - completion: An optional completion closure that will be called when the operation is complete. It takes two parameters: a boolean value indicating whether the operation was successful, and an error of type `Error` if an error occurred during the operation.
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
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
