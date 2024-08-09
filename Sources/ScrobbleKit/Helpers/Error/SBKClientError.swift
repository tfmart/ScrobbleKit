//
//  SBKClientError.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

/// Represents client-side errors that can occur when using ScrobbleKit.
public enum SBKClientError: Error, LocalizedError {
    /// Indicates that a session key is required but not available.
    ///
    /// - Call the authentication method to obtain a valid session key before performing this action.
    case missingSessionKey
    
    /// Indicates that the provided URL is not valid.
    ///
    /// -  Check the API endpoint URL and ensure all parameters are properly encoded.
    case badURL
    
    /// Indicates that the response from the Last.fm API could not be decoded.
    ///
    /// - Check if you're using the latest version of ScrobbleKit. If the issue persists, please [file an issue on the package's GitHub repository](https://github.com/tfmart/ScrobbleKit/issues/new).
    case failedToDecodeResponse
    
    /// Indicates that the requested number of items per page exceeds the allowed limit.
    ///
    /// - Reduce the 'limit' parameter in your request. The maximum allowed value for each specific API method can be found on it's documentation.
    case overLimitPerPage
    
    /// A localized description of the error.
    public var errorDescription: String? {
        switch self {
        case .missingSessionKey:
            return NSLocalizedString("A valid session key is required. Make sure you've signed in with a Last.fm account before performing this action.", comment: "")
        case .badURL:
            return NSLocalizedString("The provided URL is not valid. Please check the URL and try again.", comment: "")
        case .failedToDecodeResponse:
            return NSLocalizedString("Failed to decode the response from Last.fm. The API might have changed or returned unexpected data.", comment: "")
        case .overLimitPerPage:
            return NSLocalizedString("The requested number of items per page exceeds the allowed limit. Please reduce the number of items requested.", comment: "")
        }
    }
}
