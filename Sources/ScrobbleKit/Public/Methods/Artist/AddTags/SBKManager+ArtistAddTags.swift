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
    ///   - tags: An array of tags to be added. Accepts a maximum of 10 tags.
    /// - Returns: A boolean value indicating whether the operation was successful.
    /// - Throws: ``SBKClientError`` if the operation fails, or an error returned by the Last.fm
    @discardableResult
    func addTags(toArtist artist: String, tags: [String]) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = try AddTagsService(to: .artist(artist),
                                         tags: tags,
                                         apiKey: apiKey,
                                         secretKey: secret,
                                         sessionKey: sessionKey)
        _ = try await service.start()
        return true
    }
}
