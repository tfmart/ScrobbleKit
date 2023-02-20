//
//  SBKMethod.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

enum SBKMethod: String {
    // Auth
    case getSession = "auth.getMobileSession"
    case getToken = "auth.getToken"
    
    // Scrobble
    case scrobble = "track.scrobble"
    case loveTrack = "track.love"
    case unloveTrack = "track.unlove"
    case updateNowPlaying = "track.updateNowPlaying"
    
    // Recent tracks
    case recentTracks = "user.getRecentTracks"
    
    // Library
    case libraryArtists = "library.getArtists"
    
    // Tag
    case tagInfo = "tag.getInfo"
    case tagSimilar = "tag.getSimilar"
    case tagTopAlbums = "tag.getTopAlbums"
    case tagTopArtists = "tag.getTopArtists"
    case tagTopTags = "tag.getTopTags"
    case tagTopTracks = "tag.getTopTracks"
    case tagWeeklyChartList = "tag.getWeeklyChartList"
    
    // Track
    case addTagsToTrack = "track.addTags"
    case getCorrectedTrackInfo = "track.getCorrection"
    case getTrackInfo = "track.getInfo"
    case getSimilarTracks = "track.getSimilar"
    case getTagsForTrack = "track.getTags"
    case getTopTagsForTrack = "track.getTopTags"
    case removeTagFromTrack = "track.removeTag"
    case searchForTrack = "track.search"
    
    // Artist
    case addTagsToArtist = "artist.addTags"
    case getCorrectedArtistInfo = "artist.getCorrection"
    case getArtistInfo = "artist.getInfo"
    case getSimilarArtists = "artist.getSimilar"
    case getTagsForArtist = "artist.getTags"
    case getTopAlbumsForArtist = "artist.getTopAlbums"
    case getTopTagsForArtist = "artist.getTopTags"
    case getTopTracksForArtist = "artist.getTopTracks"
    case removeTagFromArtist = "artist.removeTag"
    case searchForArtist = "artist.search"
    
    // Album
    case addTagsToAlbum = "album.addTags"
    case getAlbumInfo = "album.getInfo"
    case getTagsForAlbum = "album.getTags"
    case getTopTagsForAlbum = "album.getTopTags"
    case removeTagFromAlbum = "album.removeTag"
    case searchForAlbum = "album.search"
    
    // Chart
    case getTopArtistsFromChart = "chart.getTopArtists"
    case getTopTagsFromChart = "chart.getTopTags"
    case getTopTracksFromChart = "chart.getTopTracks"
    
    // Geo
    case getTopArtistsInGeo = "geo.getTopArtists"
    case getTopTracksInGeo = "geo.getTopTracks"
    
    // User
    case getUserFriends = "user.getFriends"
    case getUserInfo = "user.getInfo"
    case getUserLovedTracks = "user.getLovedTracks"
    case getUserPersonalTags = "user.getPersonalTags"
    case getUserTopAlbums = "user.getTopAlbums"
    case getUserTopArtists = "user.getTopArtists"
    case getUserTopTags = "user.getTopTags"
    case getUserTopTracks = "user.getTopTracks"
    case getUserWeeklyAlbumChart = "user.getWeeklyAlbumChart"
    case getUserWeeklyArtistChart = "user.getWeeklyArtistChart"
    case getUserWeeklyChartList = "user.getWeeklyChartList"
    case getWeeklyTrackChart = "user.getWeeklyTrackChart"
    
}
