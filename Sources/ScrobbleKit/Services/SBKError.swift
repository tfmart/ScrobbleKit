//
//  SBKErrorCode.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

enum SBKError: Int, Error, Codable {
    // Last.fm service errors
    case invalidService = 2
    case invalidMethod = 3
    case unauthorized = 4
    case invalidServiceFormat = 5
    case missingRequiredParameter = 6
    case invalidResource = 7
    case backendFailed = 8
    case authenticationFailed = 9
    case invalidAPIKey = 10
    case serviceOffline = 11
    case subscriberOnly = 12
    case invalidSignature = 13
    case invalidToken = 14
    case notAvailabeForStreaming = 15
    case serviceUnavailable = 16
    case loginRequired = 17
    case suspendedApiKey = 26
    case deprecated = 27
    case rateLimitExceded = 29
    // ScrobbleKit client errors
    case missingSessionKey = 997
    case badURL = 998
    case failedToDecodeResponse = 999
}
