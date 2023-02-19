//
//  SBKWiki.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKWiki {
    public let summary: String
    public let content: String
    public let published: Date?
    
    internal init(response: SBKWikiResponse) {
        self.summary = response.summary
        self.content = response.content
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        self.published = dateFormatter.date(from: response.published)
    }
}
