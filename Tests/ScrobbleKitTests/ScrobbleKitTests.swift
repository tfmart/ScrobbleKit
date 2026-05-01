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

    func testUserWeeklyChartListBuildsExpectedQuery() throws {
        let service = UserGetWeeklyChartListService(
            user: "rj",
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyChartList"))
        XCTAssertTrue(urlString.contains("user=rj"))
    }

    func testUserWeeklyAlbumChartBuildsDateRangeQuery() throws {
        let service = UserGetWeeklyAlbumChartService(
            user: "rj",
            from: Date(timeIntervalSince1970: 1_212_321_600),
            to: Date(timeIntervalSince1970: 1_212_926_400),
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyAlbumChart"))
        XCTAssertTrue(urlString.contains("user=rj"))
        XCTAssertTrue(urlString.contains("from=1212321600"))
        XCTAssertTrue(urlString.contains("to=1212926400"))
    }

    func testUserWeeklyArtistChartBuildsDateRangeQuery() throws {
        let service = UserGetWeeklyArtistChartService(
            user: "rj",
            from: Date(timeIntervalSince1970: 1_212_321_600),
            to: Date(timeIntervalSince1970: 1_212_926_400),
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyArtistChart"))
        XCTAssertTrue(urlString.contains("user=rj"))
        XCTAssertTrue(urlString.contains("from=1212321600"))
        XCTAssertTrue(urlString.contains("to=1212926400"))
    }

    func testUserWeeklyTrackChartBuildsDateRangeQuery() throws {
        let service = UserGetWeeklyTrackChartService(
            user: "rj",
            from: Date(timeIntervalSince1970: 1_212_321_600),
            to: Date(timeIntervalSince1970: 1_212_926_400),
            apiKey: "test_api_key",
            secretKey: "test_secret_key"
        )

        let urlString = try XCTUnwrap(try service.makeRequest().url?.absoluteString)
        XCTAssertTrue(urlString.contains("method=user.getWeeklyTrackChart"))
        XCTAssertTrue(urlString.contains("user=rj"))
        XCTAssertTrue(urlString.contains("from=1212321600"))
        XCTAssertTrue(urlString.contains("to=1212926400"))
    }

    func testUserWeeklyChartListDecodesDateRanges() throws {
        let data = """
        {
          "weeklychartlist": {
            "chart": [
              { "from": "1108296002", "to": "1108900802" },
              { "from": "1108900801", "to": "1109505601" }
            ]
          }
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(SBKUserWeeklyChartListResponse.self, from: data)
        XCTAssertEqual(response.weeklyChartList.count, 2)
        XCTAssertEqual(Int(response.weeklyChartList[0].from.timeIntervalSince1970), 1_108_296_002)
        XCTAssertEqual(Int(response.weeklyChartList[0].to.timeIntervalSince1970), 1_108_900_802)
    }

    func testUserWeeklyTrackChartDecodesTracks() throws {
        let data = """
        {
          "weeklytrackchart": {
            "track": [
              {
                "artist": {
                  "#text": "Dirk Leyers",
                  "mbid": "17b0d7f1-fad3-404e-87ae-874e6e158c3a"
                },
                "name": "Wellen",
                "mbid": "",
                "playcount": "3",
                "url": "http://www.last.fm/music/Dirk+Leyers/_/Wellen"
              }
            ],
            "@attr": {
              "user": "rj",
              "from": "1212321600",
              "to": "1212926400"
            }
          }
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(SBKUserWeeklyTrackChartResponse.self, from: data)
        XCTAssertEqual(response.weeklyTrackChart.attributes.user, "rj")
        XCTAssertEqual(Int(response.weeklyTrackChart.attributes.fromDate?.timeIntervalSince1970 ?? 0), 1_212_321_600)
        XCTAssertEqual(response.weeklyTrackChart.tracks.count, 1)
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].name, "Wellen")
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].artist.name, "Dirk Leyers")
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].playcount, 3)
        XCTAssertEqual(response.weeklyTrackChart.tracks[0].url?.absoluteString, "http://www.last.fm/music/Dirk+Leyers/_/Wellen")
    }
}
