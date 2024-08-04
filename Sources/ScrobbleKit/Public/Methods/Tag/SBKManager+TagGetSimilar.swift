//
//  SBKManager+TagGetSimilar.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//


import Foundation

public extension SBKManager {
    /**
     Search for tags similar to this one. Returns tags ranked by similarity, based on listening data.
     
     - Parameter tag: The tag name.
     
     - Returns: An array of `SBKTag` representing similar tags.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: See [Last.fm's tag.getSimilar documentation](https://www.last.fm/api/show/tag.getSimilar) for more information.
     */
    func getSimilarTags(to tag: String) async throws -> [SBKTag] {
        let service = TagGetSimilarService(tag: tag, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.similarTags
    }
}
