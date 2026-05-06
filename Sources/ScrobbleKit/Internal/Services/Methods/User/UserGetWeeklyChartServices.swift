//
//  UserGetWeeklyChartServices.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation

struct UserGetWeeklyChartListService: SBKService {
    typealias ResponseType = SBKUserWeeklyChartListResponse

    var apiKey: String
    var secretKey: String

    var sbkMethod: SBKMethod = .getUserWeeklyChartList
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(user: String, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.queries = [
            .init(name: "user", value: user)
        ]
    }
}

struct UserGetWeeklyAlbumChartService: SBKService {
    typealias ResponseType = SBKUserWeeklyAlbumChartResponse

    var apiKey: String
    var secretKey: String

    var sbkMethod: SBKMethod = .getUserWeeklyAlbumChart
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(user: String, from: Date?, to: Date?, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.queries = Self.weeklyChartQueries(user: user, from: from, to: to)
    }
}

struct UserGetWeeklyArtistChartService: SBKService {
    typealias ResponseType = SBKUserWeeklyArtistChartResponse

    var apiKey: String
    var secretKey: String

    var sbkMethod: SBKMethod = .getUserWeeklyArtistChart
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(user: String, from: Date?, to: Date?, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.queries = Self.weeklyChartQueries(user: user, from: from, to: to)
    }
}

struct UserGetWeeklyTrackChartService: SBKService {
    typealias ResponseType = SBKUserWeeklyTrackChartResponse

    var apiKey: String
    var secretKey: String

    var sbkMethod: SBKMethod = .getWeeklyTrackChart
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(user: String, from: Date?, to: Date?, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.queries = Self.weeklyChartQueries(user: user, from: from, to: to)
    }
}

private extension SBKService {
    static func weeklyChartQueries(user: String, from: Date?, to: Date?) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = [
            .init(name: "user", value: user)
        ]

        if let from {
            queryItems.append(.init(name: "from", numericValue: Int(from.timeIntervalSince1970)))
        }

        if let to {
            queryItems.append(.init(name: "to", numericValue: Int(to.timeIntervalSince1970)))
        }

        return queryItems
    }
}
