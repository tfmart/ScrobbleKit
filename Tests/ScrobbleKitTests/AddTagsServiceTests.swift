//
//  AddTagsServiceTests.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import XCTest
@testable import ScrobbleKit

final class AddTagsServiceTests: XCTestCase {
    func testAddTagsAllowsUpToTenTags() {
        let tags = (1...10).map { "tag\($0)" }

        XCTAssertNoThrow(
            try AddTagsService(
                to: .artist("Cher"),
                tags: tags,
                apiKey: "test_api_key",
                secretKey: "test_secret_key",
                sessionKey: "test_session_key"
            )
        )
    }

    func testAddTagsRejectsMoreThanTenTags() {
        let tags = (1...11).map { "tag\($0)" }

        XCTAssertThrowsError(
            try AddTagsService(
                to: .artist("Cher"),
                tags: tags,
                apiKey: "test_api_key",
                secretKey: "test_secret_key",
                sessionKey: "test_session_key"
            )
        ) { error in
            guard case SBKClientError.tooManyTags = error else {
                return XCTFail("Expected tooManyTags, got \(error)")
            }
        }
    }
}
