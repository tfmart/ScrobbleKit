//
//  SBKClientError.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public enum SBKClientError: Error, LocalizedError {
    case missingSessionKey
    case badURL
    case failedToDecodeResponse
    case overLimitPerPage
    case noTracksToScrobble
    case tooManyTracks
    
    public var errorDescription: String? {
        switch self {
        case .missingSessionKey:
            return NSLocalizedString("Make sure you've signed-in with a Last.fm account before performing this action", comment: "")
        case .badURL:
            return NSLocalizedString("The provided URL is not valid", comment: "")
        case .failedToDecodeResponse:
            return NSLocalizedString("Could not read data. Please try again later", comment: "")
        case .overLimitPerPage:
            return NSLocalizedString("Cannot fetch this amount of data per page. Please, reduce the amount of data beign read", comment: "")
        case .noTracksToScrobble:
            return NSLocalizedString("No tracks provided for scrobbling", comment: "")
        case .tooManyTracks:
            return NSLocalizedString("Too many tracks provided. Maximum is 50 tracks per request", comment: "")
        }
    }
}
