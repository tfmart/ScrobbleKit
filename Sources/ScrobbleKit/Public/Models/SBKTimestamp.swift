//
//  SBKTimestamp.swift
//  
//
//  Created by Tomas Martins on 26/08/23.
//

import Foundation

public struct SBKTimestamp: Decodable {
    public let timestamp: String
    public let date: String
    
    private enum CodingKeys: String, CodingKey {
        case timestamp = "uts"
        case date = "#text"
    }
}
