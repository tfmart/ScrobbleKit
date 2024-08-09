//
//  SBKTag.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents a tag in the Last.fm ecosystem.
public struct SBKTag: Decodable {
    /// The name of the tag.
    public let name: String
    
    /// The URL of the tag's page on Last.fm.
    public let url: URL?
    
    /// The number of users that have used this tag.
    public let reach: Int?
    
    /// The total number of times this tag has been used.
    public let taggings: Int?
    
    /// Indicates if this tag can be used as a radio station.
    public let streamable: Bool?
    
    /// Wiki information about the tag, if available.
    public let wiki: SBKWiki?
    
    /// The count of this tag's usage in a specific context.
    public let count: Int?
    
    /// A string representation of the streamable property, used in some API responses.
    public let streamableString: String?
    
    /// The start date of a weekly chart for this tag, if applicable.
    public let from: Date?
    
    /// The end date of a weekly chart for this tag, if applicable.
    public let to: Date?
    
    enum CodingKeys: String, CodingKey {
        case name, url, reach, taggings, streamable, wiki, count
        case streamableString = "streamabletext"
        case from, to
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        let urlString = try container.decodeIfPresent(String.self, forKey: .url)
        url = URL(optionalString: urlString)
        reach = try container.decodeIfPresent(Int.self, forKey: .reach)
        taggings = try container.decodeIfPresent(Int.self, forKey: .taggings)
        streamable = try container.decodeIfPresent(Bool.self, forKey: .streamable)
        wiki = try container.decodeIfPresent(SBKWiki.self, forKey: .wiki)
        count = try container.decodeIfPresent(Int.self, forKey: .count)
        
        streamableString = try container.decodeIfPresent(String.self, forKey: .streamableString)
        
        if let fromTimestamp = try container.decodeIfPresent(TimeInterval.self, forKey: .from),
           let toTimestamp = try container.decodeIfPresent(TimeInterval.self, forKey: .to) {
            from = Date(timeIntervalSince1970: fromTimestamp)
            to = Date(timeIntervalSince1970: toTimestamp)
        } else {
            from = nil
            to = nil
        }
    }
    
    internal init(
        name: String,
        url: URL? = nil,
        reach: Int? = nil,
        taggings: Int? = nil,
        streamable: Bool? = nil,
        wiki: SBKWiki? = nil,
        count: Int? = nil,
        streamableString: String? = nil,
        from: Date? = nil,
        to: Date? = nil
    ) {
        self.name = name
        self.url = url
        self.reach = reach
        self.taggings = taggings
        self.streamable = streamable
        self.wiki = wiki
        self.count = count
        self.streamableString = streamableString
        self.from = from
        self.to = to
    }
}
