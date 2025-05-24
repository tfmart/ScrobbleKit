//
//  SBKManager+ArtistGetCorrectionService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public extension SBKManager {
    /// Asynchronously checks whether the supplied artist has a correction to a canonical artist
    ///
    /// - Parameters:
    ///   - artist: The artist name to correct.
    /// - Returns: The corrected artist name, or `nil` if no correction was made.
    /// - Throws: ``SBKClientError`` if the operation fails, or an error returned by the Last.fm
    func getCorrectedArtistName(_ artist: String) async throws -> SBKArtist? {
        let service = ArtistGetCorrectionService(artist: artist, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.corrections.correction.result
    }
}
