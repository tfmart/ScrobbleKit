import Foundation

public extension SBKManager {
    /**
     Get the top global tags on Last.fm, sorted by popularity.
     
     - Returns: An array of `SBKTag` representing the top tags.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/tag.getTopTags).
     */
    func getTopTags() async throws -> [SBKTag] {
        let service = TagGetTopTagsService(apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.tags
    }
}
