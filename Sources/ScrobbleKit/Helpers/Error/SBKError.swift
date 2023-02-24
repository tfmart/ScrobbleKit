//
//  SBKErrorCode.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Error codes that may be returned by the Last.fm API.
public enum SBKError: Int, Error, LocalizedError, Codable {
    // Last.fm service errors
    
    /// The service specified does not exist.
    case invalidService = 2
    
    /// The requested method does not exist.
    case invalidMethod = 3
    
    /// This token has not been authorized.
    case unauthorized = 4
    
    /// The service does not have a format that can be parsed.
    case invalidServiceFormat = 5
    
    /// The required parameter is missing.
    case missingRequiredParameter = 6
    
    /// The requested resource is not found.
    case invalidResource = 7
    
    /// The operation failed due to a system error.
    case backendFailed = 8
    
    /// Invalid authentication token.
    case authenticationFailed = 9
    
    /// This API key does not exist.
    case invalidAPIKey = 10
    
    /// The service is temporarily offline.
    case serviceOffline = 11
    
    /// This method is only available to paid Last.fm subscribers.
    case subscriberOnly = 12
    
    /// The digital signature is invalid.
    case invalidSignature = 13
    
    /// The token supplied is either invalid or has expired.
    case invalidToken = 14
    
    /// This track is not available for streaming.
    case notAvailabeForStreaming = 15
    
    /// The service is temporarily unavailable.
    case serviceUnavailable = 16
    
    /// This operation requires authentication.
    case loginRequired = 17
    
    /// This API key has been suspended.
    case suspendedApiKey = 26
    
    /// This method has been deprecated.
    case deprecated = 27
    
    /// Your IP has made too many requests in a short period.
    case rateLimitExceded = 29
    
    var localizedDescription: String {
        switch self {
        case .invalidService:
            return NSLocalizedString("The service specified does not exist.", comment: "")
        case .invalidMethod:
            return NSLocalizedString("The requested method does not exist.", comment: "")
        case .unauthorized:
            return NSLocalizedString("This token has not been authorized.", comment: "")
        case .invalidServiceFormat:
            return NSLocalizedString("The service does not have a format that can be parsed.", comment: "")
        case .missingRequiredParameter:
            return NSLocalizedString("The required parameter is missing.", comment: "")
        case .invalidResource:
            return NSLocalizedString("The requested resource is not found.", comment: "")
        case .backendFailed:
            return NSLocalizedString("The operation failed due to a system error.", comment: "")
        case .authenticationFailed:
            return NSLocalizedString("Invalid authentication token.", comment: "")
        case .invalidAPIKey:
            return NSLocalizedString("This API key does not exist.", comment: "")
        case .serviceOffline:
            return NSLocalizedString("The service is temporarily offline.", comment: "")
        case .subscriberOnly:
            return NSLocalizedString("This method is only available to paid Last.fm subscribers.", comment: "")
        case .invalidSignature:
            return NSLocalizedString("The signature is invalid.", comment: "")
        case .invalidToken:
            return NSLocalizedString("The token supplied is either invalid or has expired.", comment: "")
        case .notAvailabeForStreaming:
            return NSLocalizedString("This track is not available for streaming.", comment: "")
        case .serviceUnavailable:
            return NSLocalizedString("The service is temporarily unavailable.", comment: "")
        case .loginRequired:
            return NSLocalizedString("This operation requires authentication.", comment: "")
        case .suspendedApiKey:
            return NSLocalizedString("This API key has been suspended.", comment: "")
        case .deprecated:
            return NSLocalizedString("This method has been deprecated.", comment: "")
        case .rateLimitExceded:
            return NSLocalizedString("Your IP has made too many requests in a short period.", comment: "")
        }
    }
}

