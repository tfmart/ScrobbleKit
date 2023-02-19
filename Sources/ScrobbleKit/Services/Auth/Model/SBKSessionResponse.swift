//
//  SBKSessionResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKSessionResponse: Decodable {
    let info: SBKSessionResponseInfo
    
    enum CodingKeys: String, CodingKey {
        case info = "session"
    }
}

class SBKSessionResponseInfo: Decodable {
    let name, key: String
    let subscriber: Int
}
