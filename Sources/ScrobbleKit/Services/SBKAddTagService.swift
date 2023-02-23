//
//  SBKAddTagService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

enum SBKTaggableContent {
    case artist(_ name: String)
    case album(_ name: String, artist: String)
    case track(_ name: String, artist: String)
}

struct AddTagsService: SBKAuthenticatedService {
    typealias ResponseType = SBKEmptyResponse
    
    var taggableContent: SBKTaggableContent
    
    var sbkMethod: SBKMethod {
        switch taggableContent {
        case .artist(_):
            return .addTagsToArtist
        case .album(_, _):
            return .addTagsToAlbum
        case .track(_, _):
            return .addTagsToTrack
        }
    }
    
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    init(to taggableContent: SBKTaggableContent, tags: [String],
         apiKey: String, secretKey: String, sessionKey: String) {
        self.taggableContent = taggableContent
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        
        switch taggableContent {
        case .artist(let name):
            queries = [
                .init(name: "artist", value: name),
                .init(name: "tags", value: tags.joined(separator: ","))
            ]
        case .album(let name, let artist):
            queries = [
                .init(name: "album", value: name),
                .init(name: "artist", value: artist),
                .init(name: "tags", value: tags.joined(separator: ","))
            ]
        case .track(let title, let artist):
            queries = [
                .init(name: "track", value: title),
                .init(name: "artist", value: artist),
                .init(name: "tags", value: tags.joined(separator: ","))
            ]
        }
    }
}
