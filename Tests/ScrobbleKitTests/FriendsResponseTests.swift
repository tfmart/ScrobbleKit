//
//  FriendsResponseTests.swift
//  ScrobbleKit
//

import Foundation
import Testing
@testable import ScrobbleKit

struct FriendsResponseTests {
    private let attributes = #""@attr":{"user":"test","totalPages":"1","page":"1","total":"0","perPage":"20"}"#

    @Test(arguments: ["[]", "\"\"", "null"])
    func emptyFriends(value: String) throws {
        let data = Data("{\"friends\":{\(attributes),\"user\":\(value)}}".utf8)
        let response = try JSONDecoder().decode(SBKUserGetFriendsRootObject.self, from: data)
        #expect(response.friends.friends.isEmpty)
    }

    @Test func missingFriends() throws {
        let data = Data("{\"friends\":{\(attributes)}}".utf8)
        #expect(try JSONDecoder().decode(SBKUserGetFriendsRootObject.self, from: data).friends.friends.isEmpty)
    }

    @Test func malformedFriendsAreNotReportedAsEmpty() {
        let data = Data("{\"friends\":{\(attributes),\"user\":[{\"name\":\"incomplete\"}]}}".utf8)
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(SBKUserGetFriendsRootObject.self, from: data)
        }
    }
}
