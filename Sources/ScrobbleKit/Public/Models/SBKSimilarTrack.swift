//
//  SBKSimilarTrack.swift
//
//
//  Created by Tomas Martins on 29/01/24.
//

import Foundation

public struct SBKSimilarTrack {
    /// The track that this similar track represents
    public var track: SBKTrack
    /// The match value for the similarity between the original track and the similar track, as a percentage (from 0.0 to 1.0).
    public var match: Double?
}
