//
//  SBKTag.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/**
 A struct representing a tag returned from a Last.fm API call.
 */
public struct SBKTag: Decodable {
    
    /// The URL for the tag on the Last.fm website.
    public let url: String
    
    /// The name of the tag.
    public let name: String
}

