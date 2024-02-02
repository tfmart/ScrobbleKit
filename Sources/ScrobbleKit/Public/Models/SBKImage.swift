//
//  SBKImage.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/**
 Represents an image that may be returned from a Last.fm API call.
 */
public struct SBKImage {
    /// The URL for the small-sized image.
    public var small: String?
    
    /// The URL for the medium-sized image.
    public var medium: String?
    
    /// The URL for the large-sized image.
    public var large: String?
    
    /// The URL for the extra-large-sized image.
    public var extraLarge: String?
    
    /// The URL for the mega-sized image.
    public var mega: URL?
    
    /// Returns the URL of the largest available size among small, medium, large, extra-large, and mega.
    ///
    /// The `largestSize` property prioritizes larger sizes in descending order, returning the first non-nil URL found.
    ///
    /// - Returns: The URL of the largest available size, or `nil` if no size is available.
    public var largestSize: String? {
        let sizes = [mega, extraLarge, large, medium, small]
        return sizes.first { $0 != nil } as? String
    }
    
    internal init?(response: [SBKImageResponse]?) {
        guard let response else { return nil }
        self.small = response.first(where: { $0.size == "small" })?.text
        self.medium = response.first(where: { $0.size == "medium" })?.text
        self.large = response.first(where: { $0.size == "large" })?.text
        self.extraLarge = response.first(where: { $0.size == "extralarge" })?.text
        self.mega = response.first(where: { $0.size == "mega" })?.text
    }
}

