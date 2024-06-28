//
//  SBKManager.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension SBKManager {

    public func scrobble(track: String, artist: String, album: String?, date: Date = Date()) async throws -> SBKScrobbleResponse {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = ScrobbleService(
            artist: artist,
            track: track,
            album: album,
            date: date,
            sessionKey: sessionKey,
            apiKey: self.apiKey,
            secretKey: self.secret
        )
        do {
            let responseList = try await service.start()
            return SBKScrobbleResponse(list: responseList)
        } catch {
            throw error
        }
    }
    
    public func scrobble(track: String, artist: String, album: String?, date: Date = Date(), _ completion: ((SBKScrobbleResponse?, Error?) -> Void)? = nil) {
        guard let sessionKey else {
            completion?(nil, SBKClientError.missingSessionKey)
            return
        }
        let service = ScrobbleService(
            artist: artist,
            track: track,
            album: album,
            date: date,
            sessionKey: sessionKey,
            apiKey: self.apiKey,
            secretKey: self.secret
        )
        service.start { list, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let list else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(SBKScrobbleResponse(list: list), nil)
        }
    }
}
