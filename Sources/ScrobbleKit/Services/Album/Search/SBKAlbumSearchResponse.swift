//
//  SBKAlbumSearchResponse.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct SBKAlbumSearchResponse: Decodable {
    var results: SBKAlbumSearchResultResponse
}

struct SBKAlbumSearchResultResponse: Decodable {
    var opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String?
    var albumMatches: SBKAlbumSearchResultListResponse?
    
    enum CodingKeys: String, CodingKey {
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case albumMatches = "albummatches"
    }
}

struct SBKAlbumSearchResultListResponse: Decodable {
    var album: [SBKAlbum]?
}
