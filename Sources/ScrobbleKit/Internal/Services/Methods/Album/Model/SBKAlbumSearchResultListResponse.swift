//
//  SBKAlbumSearchResultListResponse.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

struct SBKAlbumSearchResultListResponse: Decodable, Sendable {
    var album: [SBKAlbum]?
}
