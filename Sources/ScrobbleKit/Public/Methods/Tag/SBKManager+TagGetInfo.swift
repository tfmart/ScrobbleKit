//
//  SBKManager+TagGetInfo.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public extension SBKManager {
    /**
     Get the metadata for a tag.
     
     - Parameters:
        - tag: The tag name.
        - language: The language to return the wiki in, expressed as an ISO 639 alpha-2 code. (Optional)
     
     - Returns: An `SBKTag` object containing the tag's metadata.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: See [Last.fm's tag.getInfo documentation](https://www.last.fm/api/show/tag.getInfo) for more information.
     */
    func getInfo(forTag tag: String, language: String? = nil) async throws -> SBKTag {
        let service = TagGetInfoService(tag: tag, language: language, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.tag
    }
}
