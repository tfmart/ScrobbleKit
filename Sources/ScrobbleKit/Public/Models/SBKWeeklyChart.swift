//
//  SBKWeeklyChart.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation

/// Represents an available weekly chart date range.
public struct SBKWeeklyChart: Decodable, Sendable {
    /// The start date of the chart range.
    public let from: Date
    /// The end date of the chart range.
    public let to: Date

    enum CodingKeys: String, CodingKey {
        case from, to
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let fromTimestamp = try container.decode(IntegerStringDecoder.self, forKey: .from)
        let toTimestamp = try container.decode(IntegerStringDecoder.self, forKey: .to)

        guard let from = fromTimestamp.intValue, let to = toTimestamp.intValue else {
            throw SBKClientError.failedToDecodeResponse
        }

        self.from = Date(timeIntervalSince1970: TimeInterval(from))
        self.to = Date(timeIntervalSince1970: TimeInterval(to))
    }

    internal init(from: Date, to: Date) {
        self.from = from
        self.to = to
    }
}

/// Represents a weekly chart response for a user.
public struct SBKWeeklyChartResult<Model: Decodable & Sendable>: Sendable {
    /// The Last.fm username this chart belongs to.
    public let user: String
    /// The start date of the chart range.
    public let from: Date?
    /// The end date of the chart range.
    public let to: Date?
    /// The chart entries returned by Last.fm.
    public let results: [Model]
}
