//
//  SBKOptionallyAuthenticatedService.swift
//  
//
//  Created by Tomas Martins on 25/04/23.
//

import Foundation

protocol SBKOptionallyAuthenticatedService: SBKService {
    var username: String? { get set }
    var sessionKey: String? { get set }
}

extension SBKOptionallyAuthenticatedService {
    var completedQueries: [URLQueryItem] {
        var queries = [
            .init(parameter: .format, value: "json"),
            .init(parameter: .method, value: sbkMethod.rawValue),
            .init(parameter: .apiKey, value: apiKey),
        ] + queries.filter { $0.value != nil}
        
        if let username {
            queries.append(.init(parameter: .username, value: username))
        } else if let sessionKey {
            queries.append(.init(parameter: .sessionKey, value: sessionKey))
        }
        
        return queries
    }
}
