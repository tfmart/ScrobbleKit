//
//  SBKManager+UserGetWeeklyChartsService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation

public extension SBKManager {
    /**
     Get the available weekly chart ranges for a user.

     - Parameter user: The Last.fm username to fetch chart ranges for.

     - Returns: An array of ``SBKWeeklyChart`` date ranges.

     - Note: See [Last.fm's user.getWeeklyChartList documentation](https://www.last.fm/api/show/user.getWeeklyChartList) for more information.
     */
    func getWeeklyChartList(forUser user: String) async throws -> [SBKWeeklyChart] {
        let service = UserGetWeeklyChartListService(user: user, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.weeklyChartList
    }

    /**
     Get an album chart for a user profile, for a given date range.

     - Parameters:
        - user: The Last.fm username to fetch the chart for.
        - startDate: The date at which the chart should start from.
        - endDate: The date at which the chart should end on.

     - Returns: A ``SBKWeeklyChartResult`` containing the albums and chart range.

     - Note: See [Last.fm's user.getWeeklyAlbumChart documentation](https://www.last.fm/api/show/user.getWeeklyAlbumChart) for more information.
     */
    func getWeeklyAlbumChart(
        forUser user: String,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) async throws -> SBKWeeklyChartResult<SBKAlbum> {
        let service = UserGetWeeklyAlbumChartService(
            user: user,
            from: startDate,
            to: endDate,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        let chart = response.weeklyAlbumChart
        return .init(
            user: chart.attributes.user ?? user,
            from: chart.attributes.fromDate,
            to: chart.attributes.toDate,
            results: chart.albums
        )
    }

    /**
     Get an artist chart for a user profile, for a given date range.

     - Parameters:
        - user: The Last.fm username to fetch the chart for.
        - startDate: The date at which the chart should start from.
        - endDate: The date at which the chart should end on.

     - Returns: A ``SBKWeeklyChartResult`` containing the artists and chart range.

     - Note: See [Last.fm's user.getWeeklyArtistChart documentation](https://www.last.fm/api/show/user.getWeeklyArtistChart) for more information.
     */
    func getWeeklyArtistChart(
        forUser user: String,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) async throws -> SBKWeeklyChartResult<SBKArtist> {
        let service = UserGetWeeklyArtistChartService(
            user: user,
            from: startDate,
            to: endDate,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        let chart = response.weeklyArtistChart
        return .init(
            user: chart.attributes.user ?? user,
            from: chart.attributes.fromDate,
            to: chart.attributes.toDate,
            results: chart.artists
        )
    }

    /**
     Get a track chart for a user profile, for a given date range.

     - Parameters:
        - user: The Last.fm username to fetch the chart for.
        - startDate: The date at which the chart should start from.
        - endDate: The date at which the chart should end on.

     - Returns: A ``SBKWeeklyChartResult`` containing the tracks and chart range.

     - Note: See [Last.fm's user.getWeeklyTrackChart documentation](https://www.last.fm/api/show/user.getWeeklyTrackChart) for more information.
     */
    func getWeeklyTrackChart(
        forUser user: String,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) async throws -> SBKWeeklyChartResult<SBKTrack> {
        let service = UserGetWeeklyTrackChartService(
            user: user,
            from: startDate,
            to: endDate,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        let chart = response.weeklyTrackChart
        return .init(
            user: chart.attributes.user ?? user,
            from: chart.attributes.fromDate,
            to: chart.attributes.toDate,
            results: chart.tracks
        )
    }
}
