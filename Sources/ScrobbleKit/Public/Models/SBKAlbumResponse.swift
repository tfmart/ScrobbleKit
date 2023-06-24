//
//  SBKAlbumResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKAlbumResponse {
    public var artist: String
    public var name: String
    internal var tracks: [SBKAlbumTrack]
    public var albumArt: SBKImage?
    public var tags: [SBKTag]?
    public var musicBrainzID: String?
    public var wiki: SBKWiki?
    public var playcount: String?
    public var lastFmURL: String?
    
    internal init(response: SBKAlbumRequestResponseList) {
        self.artist = response.album.name
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
    
    public var tracklist: [SBKTrack] {
        self.tracks.map {
            SBKTrack(name: $0.name,
                     duration: "\($0.duration ?? 0)",
                     artist: .init(name: $0.artist.name,
                                   musicBrainzID: $0.artist.mbid,
                                   url: $0.artist.url),
                     url: URL(string: $0.url),
                     imageList: nil)
        }
    }
}
