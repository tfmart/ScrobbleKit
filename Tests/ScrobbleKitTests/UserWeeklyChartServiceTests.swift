//
//  UserWeeklyChartServiceTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation
import XCTest
@testable import ScrobbleKit

final class UserWeeklyChartServiceTests: XCTestCase {
    func testUserWeeklyChartListBuildsExpectedQuery() throws {
        let service = UserGetWeeklyChartListService(
            user: "rj",
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyChartList"))
        XCTAssertTrue(urlString.contains("user=rj"))
    }

    func testUserWeeklyAlbumChartBuildsDateRangeQuery() throws {
        let service = UserGetWeeklyAlbumChartService(
            user: "rj",
            from: Date(timeIntervalSince1970: 1_212_321_600),
            to: Date(timeIntervalSince1970: 1_212_926_400),
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyAlbumChart"))
        XCTAssertTrue(urlString.contains("user=rj"))
        XCTAssertTrue(urlString.contains("from=1212321600"))
        XCTAssertTrue(urlString.contains("to=1212926400"))
    }

    func testUserWeeklyArtistChartBuildsDateRangeQuery() throws {
        let service = UserGetWeeklyArtistChartService(
            user: "rj",
            from: Date(timeIntervalSince1970: 1_212_321_600),
            to: Date(timeIntervalSince1970: 1_212_926_400),
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyArtistChart"))
        XCTAssertTrue(urlString.contains("user=rj"))
        XCTAssertTrue(urlString.contains("from=1212321600"))
        XCTAssertTrue(urlString.contains("to=1212926400"))
    }

    func testUserWeeklyTrackChartBuildsDateRangeQuery() throws {
        let service = UserGetWeeklyTrackChartService(
            user: "rj",
            from: Date(timeIntervalSince1970: 1_212_321_600),
            to: Date(timeIntervalSince1970: 1_212_926_400),
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyTrackChart"))
        XCTAssertTrue(urlString.contains("user=rj"))
        XCTAssertTrue(urlString.contains("from=1212321600"))
        XCTAssertTrue(urlString.contains("to=1212926400"))
    }

    func testUserWeeklyChartListDecodesDateRanges() throws {
        let data = """
        {
          "weeklychartlist": {
            "chart": [
              { "from": "1108296002", "to": "1108900802" },
              { "from": "1108900801", "to": "1109505601" }
            ]
          }
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(SBKUserWeeklyChartListResponse.self, from: data)
        XCTAssertEqual(response.weeklyChartList.count, 2)
        XCTAssertEqual(Int(response.weeklyChartList[0].from.timeIntervalSince1970), 1_108_296_002)
        XCTAssertEqual(Int(response.weeklyChartList[0].to.timeIntervalSince1970), 1_108_900_802)
    }

    func testUserWeeklyTrackChartDecodesTracks() throws {
        let data = """
        {
          "weeklytrackchart": {
            "track": [
              {
                "artist": {
                  "#text": "Dirk Leyers",
                  "mbid": "17b0d7f1-fad3-404e-87ae-874e6e158c3a"
                },
                "name": "Wellen",
                "mbid": "",
                "playcount": "3",
                "url": "http://www.last.fm/music/Dirk+Leyers/_/Wellen"
              }
            ],
            "@attr": {
              "user": "rj",
              "from": "1212321600",
              "to": "1212926400"
            }
          }
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(SBKUserWeeklyTrackChartResponse.self, from: data)
        XCTAssertEqual(response.weeklyTrackChart.attributes.user, "rj")
        XCTAssertEqual(Int(response.weeklyTrackChart.attributes.fromDate?.timeIntervalSince1970 ?? 0), 1_212_321_600)
        XCTAssertEqual(response.weeklyTrackChart.tracks.count, 1)
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].name, "Wellen")
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].artist.name, "Dirk Leyers")
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].playcount, 3)
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].url?.absoluteString, "http://www.last.fm/music/Dirk+Leyers/_/Wellen")
    }
}
