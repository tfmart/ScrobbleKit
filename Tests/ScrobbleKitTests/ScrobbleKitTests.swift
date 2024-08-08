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
    
    func testInitialization() {
        XCTAssertNotNil(manager)
        XCTAssertEqual(manager.apiKey, "test_api_key")
        XCTAssertEqual(manager.secret, "test_secret_key")
    }
    
    func testSetSessionKey() {
        let sessionKey = "test_session_key"
        manager.setSessionKey(sessionKey)
        XCTAssertEqual(manager.sessionKey, sessionKey)
    }
}
