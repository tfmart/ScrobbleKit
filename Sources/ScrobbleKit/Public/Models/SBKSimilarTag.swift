//
//  SBKSimilarTag.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

/// Represents a tag similar to a queried tag.
public struct SBKSimilarTag: Decodable {
    /// The name of the similar tag.
    public let name: String
    /// The Last.fm URL of the similar tag.
    public let url: String
    /// Indicates if the tag is streamable.
    public let streamable: Bool
}
