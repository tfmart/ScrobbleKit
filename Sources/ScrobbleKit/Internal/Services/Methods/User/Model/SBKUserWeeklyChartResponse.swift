//
//  SBKUserWeeklyChartResponse.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation

struct SBKUserWeeklyChartListResponse: Decodable, Sendable {
    let weeklyChartList: [SBKWeeklyChart]

    private enum CodingKeys: String, CodingKey {
        case weeklyChartList = "weeklychartlist"
    }

    private struct ChartList: Decodable, Sendable {
        let chart: [SBKWeeklyChart]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let chartList = try container.decode(ChartList.self, forKey: .weeklyChartList)
        self.weeklyChartList = chartList.chart
    }
}

struct SBKUserWeeklyAlbumChartResponse: Decodable, Sendable {
    let weeklyAlbumChart: SBKUserWeeklyAlbumChart

    private enum CodingKeys: String, CodingKey {
        case weeklyAlbumChart = "weeklyalbumchart"
    }
}

struct SBKUserWeeklyAlbumChart: Decodable, Sendable {
    let attributes: SBKUserWeeklyChartAttributes
    let albums: [SBKAlbum]

    private enum CodingKeys: String, CodingKey {
        case attributes = "@attr"
        case albums = "album"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try container.decode(SBKUserWeeklyChartAttributes.self, forKey: .attributes)
        self.albums = try container.decodeIfPresent([SBKAlbum].self, forKey: .albums) ?? []
    }
}

struct SBKUserWeeklyArtistChartResponse: Decodable, Sendable {
    let weeklyArtistChart: SBKUserWeeklyArtistChart

    private enum CodingKeys: String, CodingKey {
        case weeklyArtistChart = "weeklyartistchart"
    }
}

struct SBKUserWeeklyArtistChart: Decodable, Sendable {
    let attributes: SBKUserWeeklyChartAttributes
    let artists: [SBKArtist]

    private enum CodingKeys: String, CodingKey {
        case attributes = "@attr"
        case artists = "artist"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try container.decode(SBKUserWeeklyChartAttributes.self, forKey: .attributes)
        self.artists = try container.decodeIfPresent([SBKArtist].self, forKey: .artists) ?? []
    }
}

struct SBKUserWeeklyTrackChartResponse: Decodable, Sendable {
    let weeklyTrackChart: SBKUserWeeklyTrackChart

    private enum CodingKeys: String, CodingKey {
        case weeklyTrackChart = "weeklytrackchart"
    }
}

struct SBKUserWeeklyTrackChart: Decodable, Sendable {
    let attributes: SBKUserWeeklyChartAttributes
    let tracks: [SBKTrack]

    private enum CodingKeys: String, CodingKey {
        case attributes = "@attr"
        case tracks = "track"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try container.decode(SBKUserWeeklyChartAttributes.self, forKey: .attributes)
        self.tracks = try container.decodeIfPresent([SBKTrack].self, forKey: .tracks) ?? []
    }
}

struct SBKUserWeeklyChartAttributes: Decodable, Sendable {
    let user: String?
    let from: IntegerStringDecoder?
    let to: IntegerStringDecoder?

    var fromDate: Date? {
        guard let from = from?.intValue else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(from))
    }

    var toDate: Date? {
        guard let to = to?.intValue else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(to))
    }
}
