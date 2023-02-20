//
//  File.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

enum SBKClientError: Error {
    case missingSessionKey
    case badURL
    case failedToDecodeResponse
}
