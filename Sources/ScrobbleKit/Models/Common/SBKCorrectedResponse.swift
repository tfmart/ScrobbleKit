//
//  SBKCorrectedResponse.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

struct SBKCorrectedResponse<T: Decodable>: Decodable {
    var corrections: SBKCorrectedResult<T>
}

struct SBKCorrectedResult<T: Decodable>: Decodable {
    var correction: SBKCorrectedResultDetail<T>
}

struct SBKCorrectedResultDetail<T: Decodable>: Decodable {
    var result: T?
    
    enum CodingKeys: CodingKey {
        case result
    }
    
    private enum ResultCodingKeys: String, CodingKey {
        case artist = "artist"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKCorrectedResultDetail<T>.ResultCodingKeys> = try decoder.container(keyedBy: SBKCorrectedResultDetail<T>.ResultCodingKeys.self)
        
        switch "\(T.self)" {
        case "SBKArtist":
            self.result = try container.decode(T.self, forKey: SBKCorrectedResultDetail<T>.ResultCodingKeys.artist)
        default:
            fatalError("This response type is not supported")
        }
        
    }
}
