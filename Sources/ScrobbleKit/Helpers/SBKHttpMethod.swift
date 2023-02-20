//
//  SBKHttpMethod.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public enum SBKHttpMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}
