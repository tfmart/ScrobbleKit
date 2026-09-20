//
//  PaginationTests.swift
//  ScrobbleKitTests
//

import Foundation
import Testing
@testable import ScrobbleKit

struct PaginationTests {
    private let attributes = #""@attr":{"page":"2","perPage":"2","totalPages":"4","total":"7"}"#

    @Test func convertsAttributePagination() throws {
        let attributes = SBKPaginationAttributes(
            page: "2",
            perPage: "2",
            totalPages: "4",
            total: "7"
        )

        let pagination = try SBKPagination(attributes: attributes)

        #expect(pagination.page == 2)
        #expect(pagination.perPage == 2)
        #expect(pagination.totalPages == 4)
        #expect(pagination.total == 7)
    }

    @Test func preservesOpenSearchPagination() throws {
        let data = Data(##"{"results":{"opensearch:Query":{"#text":"","role":"request","searchTerms":"blue","startPage":"2"},"opensearch:totalResults":"7","opensearch:startIndex":"2","opensearch:itemsPerPage":"2","albummatches":{"album":[]}}}"##.utf8)
        let response = try JSONDecoder().decode(
            SBKSearchResultsResponse<SBKAlbumSearchResultListResponse>.self,
            from: data
        )

        let result = try SBKSearchResult<SBKAlbum>(
            results: [],
            searchTerms: [.album: "blue"],
            response: response.results
        )

        #expect(result.page == 2)
        #expect(result.startIndex == 2)
        #expect(result.perPage == 2)
        #expect(result.totalPages == nil)
        #expect(result.total == 7)
    }

    @Test func rejectsInvalidPaginationMetadata() {
        let attributes = SBKPaginationAttributes(
            page: "not-a-number",
            perPage: "2",
            totalPages: "4",
            total: "7"
        )

        do {
            _ = try SBKPagination(attributes: attributes)
            Issue.record("Expected invalid pagination metadata to throw.")
        } catch SBKClientError.failedToDecodeResponse {
            // Expected failure.
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func decodesItemsWithUnusablePaginationMetadata() throws {
        let attributeData = Data(#"{"artists":{"artist":[{"name":"Radiohead"}]}}"#.utf8)
        let searchData = Data(#"{"results":{"artistmatches":{"artist":[{"name":"Radiohead"}]}}}"#.utf8)

        let attributeResponse = try JSONDecoder().decode(SBKArtistTopChartsRequestResponse.self, from: attributeData)
        let searchResponse = try JSONDecoder().decode(
            SBKSearchResultsResponse<SBKArtistSearchResultsList>.self,
            from: searchData
        )

        #expect(attributeResponse.artists.artists.map(\.name) == ["Radiohead"])
        #expect(searchResponse.results.matches.artists.map(\.name) == ["Radiohead"])
    }

    @Test func decodesArtistPagination() throws {
        let topAlbums = Data("""
        {"topalbums":{\(attributes),"album":[{"name":"OK Computer","url":"https://www.last.fm/music/Radiohead/OK+Computer","playcount":1,"mbid":"","image":[],"artist":{"name":"Radiohead","mbid":"","url":"https://www.last.fm/music/Radiohead"}}]}}
        """.utf8)
        let topTracks = Data("""
        {"toptracks":{\(attributes),"track":[{"name":"Creep","artist":{"name":"Radiohead"}}]}}
        """.utf8)

        let albumsResponse = try JSONDecoder().decode(SBKArtistGetTopAlbumsResponse.self, from: topAlbums)
        let tracksResponse = try JSONDecoder().decode(SBKArtistTopTracksResponse.self, from: topTracks)

        #expect(albumsResponse.topAlbums.attributes?.totalPages == "4")
        #expect(tracksResponse.toptracks.attributes?.page == "2")
    }

    @Test func decodesChartPaginationAndNumericStrings() throws {
        let artists = Data("""
        {"artists":{\(attributes),"artist":[{"name":"Radiohead"}]}}
        """.utf8)
        let tags = Data("""
        {"tags":{\(attributes),"tag":[{"name":"rock","reach":"403357","taggings":"4075918","streamable":"1","wiki":{}}]}}
        """.utf8)
        let tracks = Data("""
        {"tracks":{\(attributes),"track":[{"name":"Creep","artist":{"name":"Radiohead"}}]}}
        """.utf8)

        let artistsResponse = try JSONDecoder().decode(SBKArtistTopChartsRequestResponse.self, from: artists)
        let tagsResponse = try JSONDecoder().decode(SBKChartTopTagsResponse.self, from: tags)
        let tracksResponse = try JSONDecoder().decode(SBKChartGetTopTracksResponse.self, from: tracks)
        let tag = try #require(tagsResponse.tags.tag?.first)

        #expect(artistsResponse.artists.attributes?.total == "7")
        #expect(tagsResponse.tags.attributes?.page == "2")
        #expect(tracksResponse.tracks.attributes?.perPage == "2")
        #expect(tag.reach == 403_357)
        #expect(tag.taggings == 4_075_918)
        #expect(tag.streamable == true)
        #expect(tag.wiki == nil)
    }

    @Test func decodesSingleChartTagWithPagination() throws {
        let data = Data("""
        {"tags":{\(attributes),"tag":{"name":"rock","reach":"403357","taggings":"4075918","streamable":"1","wiki":{}}}}
        """.utf8)

        let response = try JSONDecoder().decode(SBKChartTopTagsResponse.self, from: data)
        let tag = try #require(response.tags.tag?.first)

        #expect(response.tags.tag?.count == 1)
        #expect(response.tags.attributes?.page == "2")
        #expect(tag.name == "rock")
    }

    @Test func decodesGeoAndLibraryPagination() throws {
        let geo = Data("""
        {"topartists":{\(attributes),"artist":[{"name":"Radiohead"}]}}
        """.utf8)
        let library = Data("""
        {"artists":{\(attributes),"artist":[{"name":"Radiohead"}]}}
        """.utf8)

        let geoResponse = try JSONDecoder().decode(SBKGeoTopArtistsResponse.self, from: geo)
        let libraryResponse = try JSONDecoder().decode(SBKLibraryGetArtistsResponse.self, from: library)

        #expect(geoResponse.topartists.attributes?.totalPages == "4")
        #expect(libraryResponse.artists.attributes?.totalPages == "4")
    }

    @Test func decodesTagPagination() throws {
        let albums = Data("""
        {"albums":{\(attributes),"album":[{"name":"OK Computer","artist":{"name":"Radiohead"}}]}}
        """.utf8)
        let artists = Data("""
        {"topartists":{\(attributes),"artist":[{"name":"Radiohead"}]}}
        """.utf8)
        let tracks = Data("""
        {"tracks":{\(attributes),"track":[{"name":"Creep","artist":{"name":"Radiohead"}}]}}
        """.utf8)

        let albumsResponse = try JSONDecoder().decode(TagTopAlbumsResponse.self, from: albums)
        let artistsResponse = try JSONDecoder().decode(TagTopArtistsResponse.self, from: artists)
        let tracksResponse = try JSONDecoder().decode(TagTopTracksResponse.self, from: tracks)

        #expect(albumsResponse.attributes?.page == "2")
        #expect(artistsResponse.attributes?.perPage == "2")
        #expect(tracksResponse.attributes?.total == "7")
    }

    @Test func chartTagsUsesChartEndpoint() throws {
        let service = ChartGetTopTagsService(
            page: 2,
            limit: 10,
            apiKey: "test-api-key",
            secretKey: "test-secret"
        )
        let url = try #require(try service.makeRequest().url)
        let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
        let queries = Dictionary(uniqueKeysWithValues: (components.queryItems ?? []).compactMap { item in
            item.value.map { (item.name, $0) }
        })

        #expect(queries["method"] == "chart.getTopTags")
        #expect(queries["page"] == "2")
        #expect(queries["limit"] == "10")
    }

    @Test func lovedTracksUsesReportedTotalPages() throws {
        let data = Data(#"{"lovedtracks":{"@attr":{"user":"RJ","totalPages":"350","page":"1","perPage":"2","total":"700"},"track":[]}}"#.utf8)
        let response = try JSONDecoder().decode(_UserGetLovedTracksResponse.self, from: data)

        let lovedTracks = SBKLovedTracks(from: response)

        #expect(lovedTracks.searchAttributes.totalPages == "350")
        #expect(lovedTracks.searchAttributes.total == "700")
    }
}
