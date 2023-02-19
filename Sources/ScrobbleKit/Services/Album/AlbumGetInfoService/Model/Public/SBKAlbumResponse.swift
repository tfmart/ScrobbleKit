//
//  SBKAlbumResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKAlbumResponse {
    var artist: String
    var name: String
    var tracks: [SBKAlbumTrack]
    var albumArt: SBKImage?
    var tags: [SBKTag]?
    var musicBrainzID: String?
    var wiki: SBKWiki?
    var playcount: String?
    var lastFmURL: String?
    
    internal init(response: SBKAlbumRequestResponseList) {
        self.artist = response.album.artist
        self.name = response.album.name
        self.tracks = response.album.tracks?.track.compactMap({ $0 }) ?? []
        
        if let images = response.album.image {
            self.albumArt = SBKImage(response: images)
        } else {
            self.albumArt = nil
        }
        self.tags = response.album.tags?.tag
        self.musicBrainzID = response.album.mbid
        if let wiki = response.album.wiki {
            self.wiki = SBKWiki(response: wiki)
        } else {
            self.wiki = nil
        }
        self.playcount = response.album.playcount
        self.lastFmURL = response.album.url
    }
}
