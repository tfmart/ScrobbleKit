import Foundation

public extension SBKManager {
    /**
     Get the top global tags on Last.fm, sorted by popularity.
     
     - Returns: An array of `SBKTag` representing the top tags.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: See [Last.fm's tag.getTopTags documentation](https://www.last.fm/api/show/tag.getTopTags) for more information.
     */
    func getTopTags() async throws -> [SBKTag] {
        let service = TagGetTopTagsService(apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.tags
    }
}
