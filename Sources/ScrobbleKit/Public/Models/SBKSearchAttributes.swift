//
//  SBKSearchAttributes.swift
//
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

/// Represents search attributes used in Last.fm search queries
public struct SBKSearchAttributes {
    /// The search term used in the query.
    public let term: String
    /// The total number of pages available.
    public let totalPages: String
    /// The current page number.
    public let page: String
    /// The number of results per page.
    public let perPage: String
    /// The total number of results found.
    public let total: String
}
