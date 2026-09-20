//
//  SBKPaginationAttributes.swift
//  ScrobbleKit
//

import Foundation

struct SBKPaginationAttributes: Decodable, Sendable {
    let page: String?
    let perPage: String?
    let totalPages: String?
    let total: String?

    private enum CodingKeys: String, CodingKey {
        case page, perPage, totalPages, total
    }

    init(page: String?, perPage: String?, totalPages: String?, total: String?) {
        self.page = page
        self.perPage = perPage
        self.totalPages = totalPages
        self.total = total
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try? container.decodeIfPresent(String.self, forKey: .page)
        perPage = try? container.decodeIfPresent(String.self, forKey: .perPage)
        totalPages = try? container.decodeIfPresent(String.self, forKey: .totalPages)
        total = try? container.decodeIfPresent(String.self, forKey: .total)
    }
}
