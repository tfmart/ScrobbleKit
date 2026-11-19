//
//  SBKChartTopTagsResponse.swift
//  ScrobbleKit
//

import Foundation

struct SBKChartTopTagsResponse: Decodable, Sendable {
    let tags: SBKTagRequestResponseList
}
