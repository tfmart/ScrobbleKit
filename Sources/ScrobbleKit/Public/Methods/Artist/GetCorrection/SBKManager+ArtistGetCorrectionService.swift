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
    
    /// Checks whether the supplied artist has a correction to a canonical artist
    ///
    /// - Parameters:
    ///   - artist: The artist name to correct.
    ///   - completion: A closure that will be called with the corrected artist name or an error, once the operation has completed.
    func getCorrectedArtistName(_ artist: String, _ completion: ((SBKArtist?, Error?) -> Void)?) {
        let service = ArtistGetCorrectionService(artist: artist, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let correctedName = response?.corrections.correction.result else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(correctedName, nil)
        }
    }
}
