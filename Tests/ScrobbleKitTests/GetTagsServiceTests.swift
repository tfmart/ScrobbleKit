//
//  GetTagsServiceTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import XCTest
@testable import ScrobbleKit

final class GetTagsServiceTests: XCTestCase {
    func testAlbumGetTagsFallsBackToSessionKey() throws {
        let service = AlbumGetTagsService(
            searchMethod: .albumArtist(album: "Believe", artist: "Cher"),
            autoCorrect: true,
            username: nil,
            apiKey: "test_api_key",
            secretKey: "test_secret_key",
            sessionKey: "test_session_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("sk=test_session_key"))
        XCTAssertFalse(urlString.contains("user="))
    }

    func testArtistGetTagsFallsBackToSessionKey() throws {
        let service = ArtistGetTagsService(
            searchMethod: .artistName("Cher"),
            user: nil,
            autocorrect: true,
            apiKey: "test_api_key",
            secretKey: "test_secret_key",
            sessionKey: "test_session_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("sk=test_session_key"))
        XCTAssertFalse(urlString.contains("user="))
    }
}
