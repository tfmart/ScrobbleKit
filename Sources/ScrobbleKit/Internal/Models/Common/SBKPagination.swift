//
//  SBKPagination.swift
//  ScrobbleKit
//

import Foundation

struct SBKPagination: Sendable {
    let page: Int
    let perPage: Int
    let totalPages: Int
    let total: Int

    init(attributes: SBKPaginationAttributes) throws {
        guard let pageValue = attributes.page,
              let perPageValue = attributes.perPage,
              let totalPagesValue = attributes.totalPages,
              let totalValue = attributes.total,
              let page = Int(pageValue),
              let perPage = Int(perPageValue),
              let totalPages = Int(totalPagesValue),
              let total = Int(totalValue) else {
            throw SBKClientError.failedToDecodeResponse
        }

        self.page = page
        self.perPage = perPage
        self.totalPages = totalPages
        self.total = total
    }
}
