//
//  SBKAlbumResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKAlbumResponse {
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
        self.tags = response.album.tags
        self.musicBrainzID = response.album.mbid
        self.wiki = response.album.wiki
        self.playcount = response.album.playcount
        self.lastFmURL = response.album.url
    }
}
