//
//  SBKAuthenticatedService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

protocol SBKAuthenticatedService: SBKService {
    var sessionKey: String { get set }
}

extension SBKAuthenticatedService {
    var completedQueries: [URLQueryItem] {
        return [
            .init(parameter: .format, value: "json"),
            .init(parameter: .method, value: sbkMethod.rawValue),
            .init(parameter: .apiKey, value: apiKey),
            .init(parameter: .sessionKey, value: sessionKey)
        ] + queries.filter { $0.value != nil}
    }
}
