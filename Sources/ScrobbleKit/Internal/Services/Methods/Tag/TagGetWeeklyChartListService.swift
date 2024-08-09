//
//  TagGetWeeklyChartListService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct TagGetWeeklyChartListService: SBKService {
    typealias ResponseType = TagGetWeeklyChartListResponse
    
    var tag: String
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagWeeklyChartList
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(tag: String, apiKey: String, secretKey: String) {
        self.tag = tag
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "tag", value: tag)
        ]
    }
}

struct TagGetWeeklyChartListResponse: Decodable {
    let weeklyChartList: [WeeklyChartTag]
    
    enum CodingKeys: String, CodingKey {
        case weeklyChartList = "weeklychartlist"
    }
    
    struct WeeklyChartList: Decodable {
        let chart: [WeeklyChartTag]
    }
    
    struct WeeklyChartTag: Decodable {
        var text, from, to: String?
        
        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case from, to
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let chartList = try container.decode(WeeklyChartList.self, forKey: .weeklyChartList)
        self.weeklyChartList = chartList.chart
    }
}
