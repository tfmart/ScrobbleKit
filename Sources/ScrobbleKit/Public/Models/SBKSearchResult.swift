//
//  SBKSearchResult.swift
//
//
//  Created by Tomas Martins on 02/01/24.
//

import Foundation

/// Represents the result of a Last.fm search.
public struct SBKSearchResult<Model: Decodable> {
    /// The list of results retrieved from the search.
    public var results: [Model]
    /// The dictionary containing search terms and their corresponding values.
    public var searchTerms: [SBKSearchTerm: String]
    /// The current page number.
    public var page: Int
    /// The number of results per page.
    public var perPage: Int
    /// The total number of pages available.
    public var totalPages: Int
    /// The total number of results found.
    public var total: Int
}
