//
//  SBKManager+AlbumGetInfo.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

extension SBKManager {
    func getInfo(forAlbum album: String,
                 artist: String,
                 musicBrainzID: String? = nil,
                 autoCorrect: Bool = true,
                 username: String? = nil,
                 languageCode: SBKLanguageCode = .english
    ) async throws -> SBKAlbumResponse {
        let service = AlbumGetInfoService(
            album: album,
            artist: artist,
            musicBrainzID: musicBrainzID,
            autoCorrect: autoCorrect,
            username: username,
            languageCode: languageCode,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return .init(response: response)
    }
    
    func getInfo(forAlbum album: String,
                 artist: String,
                 musicBrainzID: String? = nil,
                 autoCorrect: Bool = true,
                 username: String? = nil,
                 languageCode: SBKLanguageCode = .english,
                 _ completion: ((SBKAlbumResponse?, Error?) -> Void)?
    ) {
        let service = AlbumGetInfoService(
            album: album,
            artist: artist,
            musicBrainzID: musicBrainzID,
            autoCorrect: autoCorrect,
            username: username,
            languageCode: languageCode,
            apiKey: apiKey,
            secretKey: secret
        )
        
        service.start { album, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let album else {
                completion?(nil, SBKError.failedToDecodeResponse)
                return
            }
            completion?(.init(response: album), nil)
        }
    }
}
