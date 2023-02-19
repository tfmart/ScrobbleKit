//
//  SBKImage.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKImage {
    public var small: String?
    public var medium: String?
    public var large: String?
    public var extraLarge: String?
    public var mega: String?
    
    internal init(response: [SBKImageResponse]) {
        self.small = response.first(where: {$0.size == "small"})?.text
        self.medium = response.first(where: {$0.size == "medium"})?.text
        self.large = response.first(where: {$0.size == "large"})?.text
        self.extraLarge = response.first(where: {$0.size == "extralarge"})?.text
        self.mega = response.first(where: {$0.size == "mega"})?.text
    }
}
