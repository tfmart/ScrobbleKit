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
public struct SBKWiki {
    
    /// The summary of the wiki entry.
    public let summary: String
    
    /// The content of the wiki entry.
    public let content: String
    
    /// The date and time the wiki entry was published, or `nil` if the date couldn't be parsed.
    public let published: Date?
    
    /**
     Initializes a new `SBKWiki` instance based on a `SBKWikiResponse`.
     
     - Parameter response: A `SBKWikiResponse` instance representing the wiki entry.
     */
    internal init(response: SBKWikiResponse) {
        self.summary = response.summary
        self.content = response.content
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        self.published = dateFormatter.date(from: response.published)
    }
}

