//
//  GetInfoServiceTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import XCTest
@testable import ScrobbleKit

final class GetInfoServiceTests: XCTestCase {
    func testAlbumGetInfoUsesUsernameParameter() throws {
        let service = AlbumGetInfoService(
            searchMethod: .albumArtist(album: "Believe", artist: "Cher"),
            autoCorrect: true,
            username: "rj",
            languageCode: .english,
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("username=rj"))
        XCTAssertFalse(urlString.contains("user=rj"))
    }

    func testArtistGetInfoUsesUsernameParameter() throws {
        let service = ArtistGetInfoService(
            searchMethod: .artistName("Cher"),
            autoCorrect: true,
            username: "rj",
            languageCode: .english,
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("username=rj"))
        XCTAssertFalse(urlString.contains("user=rj"))
    }

    func testTrackGetInfoCanUseMusicBrainzIDWithoutTrackAndArtist() throws {
        let service = TrackGetInfoService(
            searchMethod: .musicBrainzID("37d516ab-d61f-4bcb-9316-7a0b3eb845a8"),
            username: "rj",
            autoCorrect: false,
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("mbid=37d516ab-d61f-4bcb-9316-7a0b3eb845a8"))
        XCTAssertTrue(urlString.contains("username=rj"))
        XCTAssertTrue(urlString.contains("autocorrect=0"))
        XCTAssertFalse(urlString.contains("track="))
        XCTAssertFalse(urlString.contains("artist="))
        XCTAssertFalse(urlString.contains("lang="))
    }
}
