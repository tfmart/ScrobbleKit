//
//  SBKAddTagAlbumResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKAddTagAlbumResponse: Decodable, Sendable {
    let tags: SBKTagRequestResponseList
}
