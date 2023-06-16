//
//  SBKClientError.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public enum SBKClientError: Error {
    case missingSessionKey
    case badURL
    case failedToDecodeResponse
}
