//
//  ScrobbleKitTests.swift
//
//
//  Created by Tomas Martins on 28/12/23.
//

import XCTest
@testable import ScrobbleKit

final class ScrobbleKitTests: XCTestCase {
    var manager: SBKManager!
    
    override func setUp() {
        super.setUp()
        manager = SBKManager(apiKey: "test_api_key", secret: "test_secret_key")
    }
    
    override func tearDown() {
        manager = nil
        super.tearDown()
    }
    
    func testInitialization() async {
        XCTAssertNotNil(manager)
        let apiKey = await manager.apiKey
        let secret = await manager.secret

        XCTAssertEqual(apiKey, "test_api_key")
        XCTAssertEqual(secret, "test_secret_key")
    }
    
    func testSetSessionKey() async {
        let sessionKey = "test_session_key"
        await manager.setSessionKey(sessionKey)
        let storedSessionKey = await manager.sessionKey

        XCTAssertEqual(storedSessionKey, sessionKey)
    }

    func testGetRequestEncodesParametersInURL() throws {
        let service = RequestBuildingTestService(httpMethod: .get)
        let request = try service.makeRequest()

        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertNil(request.httpBody)
        XCTAssertEqual(request.url?.scheme, "https")
        XCTAssertEqual(request.url?.host, "ws.audioscrobbler.com")

        let urlString = try XCTUnwrap(request.url?.absoluteString)
        XCTAssertTrue(urlString.contains("format=json"))
        XCTAssertTrue(urlString.contains("method=track.search"))
        XCTAssertTrue(urlString.contains("api_key=test_api_key"))
        XCTAssertTrue(urlString.contains("track=Test%20Track"))
        XCTAssertTrue(urlString.contains("api_sig="))
    }

    func testPostRequestEncodesParametersInBody() throws {
        let service = RequestBuildingTestService(httpMethod: .post)
        let request = try service.makeRequest()

        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertNil(request.url?.query)
        XCTAssertEqual(request.url?.absoluteString, "https://ws.audioscrobbler.com/2.0/")
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Content-Type"),
            "application/x-www-form-urlencoded; charset=utf-8"
        )

        let body = try XCTUnwrap(request.httpBody)
        let bodyString = try XCTUnwrap(String(data: body, encoding: .utf8))
        XCTAssertTrue(bodyString.contains("format=json"))
        XCTAssertTrue(bodyString.contains("method=track.search"))
        XCTAssertTrue(bodyString.contains("api_key=test_api_key"))
        XCTAssertTrue(bodyString.contains("track=Test%20Track"))
        XCTAssertTrue(bodyString.contains("api_sig="))
    }

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
