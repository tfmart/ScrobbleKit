//
//  RemoveTagService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct RemoveTagService: SBKAuthenticatedService {
    typealias ResponseType = SBKEmptyResponse
    
    var taggableContent: SBKTaggableContent
    
    var sbkMethod: SBKMethod {
        switch taggableContent {
        case .artist(_):
            return .removeTagFromArtist
        case .album(_, _):
            return .removeTagFromAlbum
        case .track(_, _):
            return .removeTagFromTrack
        }
    }
    
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    init(to taggableContent: SBKTaggableContent, tag: String,
         apiKey: String, secretKey: String, sessionKey: String) {
        self.taggableContent = taggableContent
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        
        switch taggableContent {
        case .artist(let name):
            queries = [
                .init(name: "artist", value: name),
                .init(name: "tag", value: tag)
            ]
        case .album(let name, let artist):
            queries = [
                .init(name: "album", value: name),
                .init(name: "artist", value: artist),
                .init(name: "tag", value: tag)
            ]
        case .track(let title, let artist):
            queries = [
                .init(name: "track", value: title),
                .init(name: "artist", value: artist),
                .init(name: "tag", value: tag)
            ]
        }
    }
}
