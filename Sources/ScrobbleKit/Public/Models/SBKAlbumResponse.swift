//
//  SBKAlbumResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents the response to the `album.getInfo` method
public struct SBKAlbumResponse {
    /// The artist of the album.
    public var artist: String
    /// The name of the album.
    public var name: String
    /// The list of tracks associated with the album.
    internal var tracks: [SBKAlbumTrack]
    /// The album artwork image.
    public var artwork: SBKImage?
    /// The list of tags associated with the album.
    public var tags: [SBKTag]?
    /// The MusicBrainz ID of the album, if available.
    public var musicBrainzID: String?
    /// The wiki information associated with the album.
    public var wiki: SBKWiki?
    /// The playcount of the album.
    public var playcount: String?
    /// The Last.fm URL of the album.
    public var lastFmURL: String?
    
    internal init(response: SBKAlbumRequestResponseList) {
        self.artist = response.album.artist
        self.name = response.album.name
        self.tracks = response.album.tracks?.track.compactMap({ $0 }) ?? []
        
        if let images = response.album.image {
            self.artwork = SBKImage(response: images)
        } else {
            self.artwork = nil
        }
        self.tags = response.album.tags
        self.musicBrainzID = response.album.mbid
        self.wiki = response.album.wiki
        self.playcount = response.album.playcount
        self.lastFmURL = response.album.url
    }
    
    /// The tracklist associated with the album.
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
