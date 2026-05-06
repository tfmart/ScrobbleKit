//
//  TopTagsServiceTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import XCTest
@testable import ScrobbleKit

final class TopTagsServiceTests: XCTestCase {
    func testTrackGetTopTagsUsesRequestedAutocorrectValue() throws {
        let service = TrackGetTopTagsService(
            searchMethod: .trackInfo("Believe", artist: "Cher"),
            autoCorrect: false,
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("autocorrect=0"))
    }

    func testArtistGetTopTagsBuildsExpectedQuery() throws {
        let service = ArtistGetTopTagsService(
            searchMethod: .artistName("Cher"),
            autoCorrect: false,
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=artist.getTopTags"))
        XCTAssertTrue(urlString.contains("artist=Cher"))
        XCTAssertTrue(urlString.contains("autocorrect=0"))
    }
}
