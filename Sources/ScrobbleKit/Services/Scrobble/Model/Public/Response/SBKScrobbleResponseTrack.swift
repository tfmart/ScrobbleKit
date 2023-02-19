//
//  SBKScrobbleResponseTrack.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKScrobbleResponseTrack {
    let artist: String
    let title: String
    let album: String?
    let timestamp: String
    let correctedAttributes: [SBKScrobbleResponseAttribute]
    let status: SBKScrobbleResponseTrackStatus
}
