//
//  SBKScrobbleResponseTrackStatus.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public enum SBKScrobbleResponseTrackStatus {
    case accepted
    case ignored(message: String?)
}
