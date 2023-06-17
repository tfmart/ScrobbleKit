//
//  SBKSearchResultsResponse.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKSearchResultsResponse<T: Decodable>: Decodable {
    let results: SBKSearchResultsDetails<T>
}

struct SBKSearchResultsDetails<T: Decodable>: Decodable {
    let query: SBKSearchQuery
    let totalResults: String
    let startIndex: String
    let itemsPerPage: String
    let matches: T
    
    private enum CodingKeys: String, CodingKey {
        case query = "opensearch:Query"
        case totalResults = "opensearch:totalResults"
        case startIndex = "opensearch:startIndex"
        case itemsPerPage = "opensearch:itemsPerPage"
        case matches
    }
    
    private enum MatchesCodingKeys: String, CodingKey {
        case album = "albummatches"
        case artist = "artistmatches"
        case track = "trackmatches"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKSearchResultsDetails<T>.CodingKeys> = try decoder.container(keyedBy: SBKSearchResultsDetails<T>.CodingKeys.self)
        
        self.query = try container.decode(SBKSearchQuery.self, forKey: SBKSearchResultsDetails<T>.CodingKeys.query)
        self.totalResults = try container.decode(String.self, forKey: SBKSearchResultsDetails<T>.CodingKeys.totalResults)
        self.startIndex = try container.decode(String.self, forKey: SBKSearchResultsDetails<T>.CodingKeys.startIndex)
        self.itemsPerPage = try container.decode(String.self, forKey: SBKSearchResultsDetails<T>.CodingKeys.itemsPerPage)
        
        let matchesContainer: KeyedDecodingContainer<SBKSearchResultsDetails<T>.MatchesCodingKeys> = try decoder.container(keyedBy: SBKSearchResultsDetails<T>.MatchesCodingKeys.self)
        switch "\(T.self)" {
        case "SBKArtistSearchResultsList":
            self.matches = try matchesContainer.decode(T.self, forKey: SBKSearchResultsDetails<T>.MatchesCodingKeys.artist)
        case "SBKAlbumSearchResultListResponse":
            self.matches = try matchesContainer.decode(T.self, forKey: SBKSearchResultsDetails<T>.MatchesCodingKeys.album)
        case "SBKTrackSearchResultListResponse":
            self.matches = try matchesContainer.decode(T.self, forKey: SBKSearchResultsDetails<T>.MatchesCodingKeys.track)
        default:
            fatalError("This response type is not supported")
        }
    }
}
