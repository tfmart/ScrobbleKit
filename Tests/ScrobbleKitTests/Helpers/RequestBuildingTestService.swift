//
//  RequestBuildingTestService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation
@testable import ScrobbleKit

struct RequestBuildingTestService: SBKService {
    typealias ResponseType = SBKEmptyResponse

    var sbkMethod: SBKMethod = .searchForTrack
    var queries: [URLQueryItem] = [
        URLQueryItem(name: "track", value: "Test Track")
    ]
    var httpMethod: SBKHttpMethod
    var apiKey: String = "test_api_key"
    var secretKey: String = "test_secret_key"
}
