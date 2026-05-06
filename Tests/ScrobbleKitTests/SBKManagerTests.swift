//
//  SBKManagerTests.swift
//
//
//  Created by Tomas Martins on 28/12/23.
//

import XCTest
@testable import ScrobbleKit

final class SBKManagerTests: XCTestCase {
    func testInitialization() async {
        let manager = SBKManager(apiKey: "test_api_key", secret: "test_secret_key")

        XCTAssertNotNil(manager)
        let apiKey = await manager.apiKey
        let secret = await manager.secret

        XCTAssertEqual(apiKey, "test_api_key")
        XCTAssertEqual(secret, "test_secret_key")
    }

    func testSetSessionKey() async {
        let manager = SBKManager(apiKey: "test_api_key", secret: "test_secret_key")
        let sessionKey = "test_session_key"
        await manager.setSessionKey(sessionKey)
        let storedSessionKey = await manager.sessionKey

        XCTAssertEqual(storedSessionKey, sessionKey)
    }
}
