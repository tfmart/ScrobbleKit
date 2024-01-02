//
//  SBKLovedTracks.swift
//
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

/// Represents information about an user's Loved Tracks list.
public struct SBKLovedTracks {
    /// The attributes of the current query
    public let searchAttributes: SBKSearchAttributes
    /// The list of tracks in the list.
    public let tracks: [SBKLovedTrack]
    
    internal init(from response: _UserGetLovedTracksResponse) {
        let responseAttributes = response.lovedtracks.attributes
        self.searchAttributes = SBKSearchAttributes(
            term: responseAttributes.user,
            totalPages: responseAttributes.total,
            page: responseAttributes.page,
            perPage: responseAttributes.perPage,
            total: responseAttributes.total
        )
        
        let responseTrackList = response.lovedtracks.track
        self.tracks = responseTrackList.map {
            let track = SBKTrack(
                name: $0.name,
                mbid: $0.mbid,
                playcount: nil,
                listeners: nil,
                duration: nil,
                artist: $0.artist,
                url: URL(string: $0.url),
                imageList: $0.image
            )
            
            var date: Date? = nil
            
            if let timeInterval = TimeInterval($0.date.timestamp) {
                date = Date(timeIntervalSince1970: timeInterval)
            }
            
            return SBKLovedTrack(track: track, date: date)
        }
    }
}
