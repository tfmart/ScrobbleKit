//
//  SBKScrobbleError.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//


/// Represents possible error cases when scrobbling a track.
public enum SBKScrobbleError: String, Error {
    case artistIgnored = "Artist was ignored"
    case trackIgnored = "Track was ignored"
    case timestampTooOld = "Timestamp was too old"
    case timestampTooNew = "Timestamp was too new"
    case dailyScrobbleLimitExceeded = "Daily scrobble limit exceeded"
    case unknown = "Unknown error"
    
    init(code: String) {
        switch code {
        case "1": self = .artistIgnored
        case "2": self = .trackIgnored
        case "3": self = .timestampTooOld
        case "4": self = .timestampTooNew
        case "5": self = .dailyScrobbleLimitExceeded
        default: self = .unknown
        }
    }
}
