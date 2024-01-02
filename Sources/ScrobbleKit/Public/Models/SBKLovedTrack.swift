//
//  SBKLovedTrack.swift
//  
//
//  Created by Tomas Martins on 02/01/24.
//

import Foundation

/// Represents information about a track on an user's Loved Tracks list.
public struct SBKLovedTrack {
    /// The track loved by the user.
    public let track: SBKTrack
    /// The date the song has been added to the Loved Tracks list.
    public let date: Date?
}
