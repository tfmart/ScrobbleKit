//
//  String+MD5.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = CryptoKit.Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
