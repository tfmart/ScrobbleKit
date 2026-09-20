//
//  SBKSearchResult+Pagination.swift
//  ScrobbleKit
//

import Foundation

extension SBKSearchResult {
    init(
        results: [Model],
        searchTerms: [SBKSearchTerm: String],
        pagination: SBKPagination
    ) {
        self.init(
            results: results,
            searchTerms: searchTerms,
            page: pagination.page,
            perPage: pagination.perPage,
            totalPages: pagination.totalPages,
            total: pagination.total
        )
    }

    init<Matches>(
        results: [Model],
        searchTerms: [SBKSearchTerm: String],
        response: SBKSearchResultsDetails<Matches>
    ) throws {
        guard let startPageValue = response.query?.startPage,
              let startIndexValue = response.startIndex,
              let itemsPerPageValue = response.itemsPerPage,
              let totalResultsValue = response.totalResults,
              let page = Int(startPageValue),
              let startIndex = Int(startIndexValue),
              let perPage = Int(itemsPerPageValue),
              let total = Int(totalResultsValue) else {
            throw SBKClientError.failedToDecodeResponse
        }

        self.init(
            results: results,
            searchTerms: searchTerms,
            page: page,
            perPage: perPage,
            totalPages: nil,
            total: total,
            startIndex: startIndex
        )
    }
}
