//
//  SBKManager+TagGetWeeklyChartList.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public extension SBKManager {
    /**
     Get a list of available charts for this tag, expressed as date ranges which can be sent to the chart services.
     
     - Parameter tag: The tag name.
     
     - Returns: An array of `SBKTag` objects representing available charts for the tag.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: See [Last.fm's tag.getWeeklyChartList documentation](https://www.last.fm/api/show/tag.getWeeklyChartList) for more information.
     */
    func getWeeklyChartList(forTag tag: String) async throws -> [SBKTag] {
        let service = TagGetWeeklyChartListService(tag: tag, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.weeklyChartList
    }
}