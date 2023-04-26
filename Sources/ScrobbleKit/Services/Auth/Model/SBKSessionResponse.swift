//
//  SBKSessionResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKSessionResponse: Decodable {
    public let info: SBKSessionResponseInfo
    
    enum CodingKeys: String, CodingKey {
        case info = "session"
    }
}

public class SBKSessionResponseInfo: Decodable {
    public let name, key: String
    public let subscriber: Int
}
