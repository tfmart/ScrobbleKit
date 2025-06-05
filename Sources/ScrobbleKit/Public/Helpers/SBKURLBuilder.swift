//
//  SBKURLBuilder.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 09/08/24.
//

import Foundation

/// A utility struct for building Last.fm URLs.
public struct SBKURLBuilder {
    /// Constructs a URL for a specific track by a specific artist on Last.fm.
    ///
    /// - Parameters:
    ///   - track: The name of the track.
    ///   - artist: The name of the artist.
    /// - Returns: A URL pointing to the track's page on Last.fm.
    /// - Throws: `SBKURLBuilderError` if URL construction fails.
    public static func url(forTrack track: String, byArtist artist: String) throws -> URL {
        let encodedTrack = try encode(track)
        let encodedArtist = try encode(artist)
        let baseURL = try baseURL()
        guard let url = URL(string: "music/\(encodedArtist)/_/\(encodedTrack)", relativeTo: baseURL) else {
            throw SBKURLBuilderError.generatedBadURL
        }
        return url
    }
    
    /// Constructs a URL for a specific artist on Last.fm.
    ///
    /// - Parameter artist: The name of the artist.
    /// - Returns: A URL pointing to the artist's page on Last.fm.
    /// - Throws: `SBKURLBuilderError` if URL construction fails.
    public static func url(forArtist artist: String) throws -> URL {
        let encodedArtist = try encode(artist)
        let baseURL = try baseURL()
        guard let url = URL(string: "music/\(encodedArtist)", relativeTo: baseURL) else {
            throw SBKURLBuilderError.generatedBadURL
        }
        return url
    }
    
    /// Constructs a URL for a specific album by a specific artist on Last.fm.
    ///
    /// - Parameters:
    ///   - album: The name of the album.
    ///   - artist: The name of the artist.
    /// - Returns: A URL pointing to the album's page on Last.fm.
    /// - Throws: `SBKURLBuilderError` if URL construction fails.
    public static func url(forAlbum album: String, byArtist artist: String) throws -> URL {
        let encodedAlbum = try encode(album)
        let encodedArtist = try encode(artist)
        let baseURL = try baseURL()
        guard let url = URL(string: "music/\(encodedArtist)/\(encodedAlbum)", relativeTo: baseURL) else {
            throw SBKURLBuilderError.generatedBadURL
        }
        return url
    }
    
    /// Constructs a URL for a specific tag on Last.fm.
    ///
    /// - Parameter tag: The name of the tag.
    /// - Returns: A URL pointing to the tag's page on Last.fm.
    /// - Throws: `SBKURLBuilderError` if URL construction fails.
    public static func url(forTag tag: String) throws -> URL {
        let encodedTag = try encode(tag)
        let baseURL = try baseURL()
        guard let url = URL(string: "tag/\(encodedTag)", relativeTo: baseURL) else {
            throw SBKURLBuilderError.generatedBadURL
        }
        return url
    }
    
    private static func encode(_ string: String) throws -> String {
        guard let encodedString = string
            .replacingOccurrences(of: "+", with: "%252B")
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw SBKURLBuilderError.badParameter(string)
        }
        return encodedString
    }
    
    private static func baseURL() throws -> URL {
        guard let url = URL(string: "https://www.last.fm") else {
            throw SBKURLBuilderError.badBaseURL
        }
        return url
    }
}
