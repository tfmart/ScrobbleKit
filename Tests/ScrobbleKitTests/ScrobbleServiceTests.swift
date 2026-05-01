//
//  ScrobbleServiceTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation
import XCTest
@testable import ScrobbleKit

final class ScrobbleServiceTests: XCTestCase {
    func testScrobbleRequestKeepsLargeBatchesOutOfURL() throws {
        let tracks = (0..<50).map { index in
            SBKTrackToScrobble(
                artist: "Artist \(index) with a deliberately long name",
                track: "Track \(index) with enough words to make the old URL too long",
                timestamp: Date(timeIntervalSince1970: 1_700_000_000 + TimeInterval(index)),
                album: "Album \(index)",
                duration: 300,
                chosenByUser: true
            )
        }
        let service = ScrobbleService(
            tracks: tracks,
            sessionKey: "test_session_key",
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let request = try service.makeRequest()
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://ws.audioscrobbler.com/2.0/")
        XCTAssertNil(request.url?.query)

        let body = try XCTUnwrap(request.httpBody)
        let bodyString = try XCTUnwrap(String(data: body, encoding: .utf8))
        XCTAssertGreaterThan(bodyString.count, request.url?.absoluteString.count ?? 0)
        XCTAssertTrue(bodyString.contains("method=track.scrobble"))
        XCTAssertTrue(bodyString.contains("artist%5B49%5D=Artist%2049"))
        XCTAssertTrue(bodyString.contains("chosenByUser%5B49%5D=1"))
        XCTAssertTrue(bodyString.contains("api_sig="))
    }
}
