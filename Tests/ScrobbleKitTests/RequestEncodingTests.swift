//
//  RequestEncodingTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import XCTest
@testable import ScrobbleKit

final class RequestEncodingTests: XCTestCase {
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
}
