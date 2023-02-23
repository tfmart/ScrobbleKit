//
//  SBKParameter.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

enum SBKParameter: String {
    case format
    case method
    case apiKey = "api_key"
    case apiSig = "api_sig"
    case sessionKey = "sk"
    case autoCorrect = "autocorrect"
    
    static let baseURL = "https://ws.audioscrobbler.com/2.0/"
}
