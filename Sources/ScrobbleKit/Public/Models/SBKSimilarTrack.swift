//
//  SBKSimilarTrack.swift
//
//
//  Created by Tomas Martins on 29/01/24.
//

import Foundation

/// Represents a track that is similar to another track, as determined by Last.fm.
public struct SBKSimilarTrack {
    /// The track that this similar track represents.
    public var track: SBKTrack
    
    /// The match value for the similarity between the original track and this similar track.
    ///
    /// This value is a percentage represented as a decimal between 0.0 and 100.0
    /// A higher value indicates a stronger similarity.
    public var match: Double?
}
