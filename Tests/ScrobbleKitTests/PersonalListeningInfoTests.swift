//
//  PersonalListeningInfoTests.swift
//  ScrobbleKit
//

import Foundation
import Testing
@testable import ScrobbleKit

struct PersonalListeningInfoTests {
    @Test(arguments: ["\"7\"", "7", "\"0\"", "0"])
    func trackAndAlbumPersonalCounts(value: String) throws {
        let count = Int(value.replacingOccurrences(of: "\"", with: ""))
        let json = Data("{\"name\":\"Song\",\"artist\":\"Artist\",\"playcount\":\"999\",\"userplaycount\":\(value)}".utf8)
        let track = try JSONDecoder().decode(SBKTrack.self, from: json)
        let album = try JSONDecoder().decode(SBKAlbum.self, from: json)
        #expect(track.userPlaycount == count)
        #expect(album.userPlaycount == count)
        #expect(track.playcount == 999)
        #expect(album.playcount == 999)
    }

    @Test(arguments: ["\"1\"", "1", "\"0\"", "0", "null", "\"invalid\""])
    func lovedStatus(value: String) throws {
        let track = try JSONDecoder().decode(SBKTrack.self, from: Data("{\"name\":\"Song\",\"artist\":\"Artist\",\"userloved\":\(value)}".utf8))
        let expected: Bool? = value.contains("1") ? true : value.contains("0") ? false : nil
        #expect(track.isLoved == expected)
    }

    @Test func missingPersonalInfoStaysUnknown() throws {
        let json = Data(#"{"name":"Song","artist":"Artist","playcount":"999"}"#.utf8)
        #expect(try JSONDecoder().decode(SBKTrack.self, from: json).userPlaycount == nil)
        #expect(try JSONDecoder().decode(SBKTrack.self, from: json).isLoved == nil)
        #expect(try JSONDecoder().decode(SBKAlbum.self, from: json).userPlaycount == nil)
    }

    @Test(arguments: ["\"4\"", "4", "null"])
    func artistInfoReadsNestedPersonalCount(value: String) throws {
        let json = Data("{\"artist\":{\"name\":\"Artist\",\"url\":\"https://www.last.fm/music/Artist\",\"stats\":{\"playcount\":\"99\",\"listeners\":\"9\",\"userplaycount\":\(value)}}}".utf8)
        let response = try JSONDecoder().decode(SBKArtistGetInfoRequestResponse.self, from: json)
        let artist = SBKArtist(getInfoData: response)
        #expect(artist.userPlaycount == (value == "null" ? nil : 4))
        #expect(artist.playcount == 99)
    }
}
