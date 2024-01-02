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

/// Represents the information retrieved after a successful authentication with Last.fm services.
public class SBKSessionResponseInfo: Decodable {
    /// The username associated with the authenticated account.
    public let name: String
    /// The session token generated for the current user session.
    public let key: String
    /// Indicates whether the user is subscribed to Last.fm Pro.
    public let isPro: Bool
    
    enum CodingKeys: CodingKey {
        case name
        case key
        case subscriber
    }
    
    public required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKSessionResponseInfo.CodingKeys> = try decoder.container(keyedBy: SBKSessionResponseInfo.CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: SBKSessionResponseInfo.CodingKeys.name)
        self.key = try container.decode(String.self, forKey: SBKSessionResponseInfo.CodingKeys.key)
        let subscriber = try container.decode(Int.self, forKey: SBKSessionResponseInfo.CodingKeys.subscriber)
        self.isPro = Bool(truncating: subscriber as NSNumber)
    }
}
