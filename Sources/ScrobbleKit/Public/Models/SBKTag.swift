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
    public let url: String?
    
    /// The name of the tag.
    public let name: String
    
    public let reach: Int?
    
    public let count: Int?
    
    public let wiki: SBKWiki?
    
    enum CodingKeys: CodingKey {
        case url
        case name
        case reach
        case count
        case wiki
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKTag.CodingKeys> = try decoder.container(keyedBy: SBKTag.CodingKeys.self)
        
        self.url = try container.decodeIfPresent(String.self, forKey: SBKTag.CodingKeys.url)
        self.name = try container.decode(String.self, forKey: SBKTag.CodingKeys.name)
        self.reach = try container.decodeIfPresent(Int.self, forKey: SBKTag.CodingKeys.reach)
        self.count = try? container.decodeIfPresent(Int.self, forKey: SBKTag.CodingKeys.count)
        self.wiki = try container.decodeIfPresent(SBKWiki.self, forKey: SBKTag.CodingKeys.wiki)
        
    }
}

