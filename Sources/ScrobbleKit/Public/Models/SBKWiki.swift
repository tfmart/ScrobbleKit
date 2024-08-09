//
//  SBKWiki.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/**
 A model representing a wiki entry.
 */
public struct SBKWiki: Decodable {
    
    /// The summary of the wiki entry.
    public let summary: String
    
    /// The content of the wiki entry.
    public let content: String
    
    /// The date and time the wiki entry was published, or `nil` if the date couldn't be parsed.
    public var published: Date? {
        guard let publishedString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        return dateFormatter.date(from: publishedString)
    }
    
    private let publishedString: String?
    
    enum CodingKeys: String, CodingKey {
        case summary
        case content
        case publishedString = "published"
    }
}

