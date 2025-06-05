//
//  SBKAlbumTopTagsResponse.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct SBKAlbumTopTagsResponse: Decodable, Sendable {
    let toptags: SBKTagRequestResponseList
}
