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
    public var small: URL?
    
    /// The URL for the medium-sized image.
    public var medium: URL?
    
    /// The URL for the large-sized image.
    public var large: URL?
    
    /// The URL for the extra-large-sized image.
    public var extraLarge: URL?
    
    /// The URL for the mega-sized image.
    public var mega: URL?
    
    /// Returns the URL of the largest available size among small, medium, large, extra-large, and mega.
    ///
    /// The `largestSize` property prioritizes larger sizes in descending order, returning the first non-nil URL found.
    ///
    /// - Returns: The URL of the largest available size, or `nil` if no size is available.
    public var largestSize: URL? {
        let sizes = [mega, extraLarge, large, medium, small]
        let largestImage = sizes.first { $0 != nil }
        guard let url = largestImage else { return nil }
        return url
    }
    
    internal init?(response: [SBKImageResponse]?) {
        guard let response else { return nil }
        let smallString = response.first(where: { $0.size == "small" })?.text
        self.small = URL(optionalString: smallString)
        let mediumString = response.first(where: { $0.size == "medium" })?.text
        self.medium = URL(optionalString: mediumString)
        let largeString = response.first(where: { $0.size == "large" })?.text
        self.large = URL(optionalString: largeString)
        let extraLargeString = response.first(where: { $0.size == "extralarge" })?.text
        self.extraLarge = URL(optionalString: extraLargeString)
        let megaString = response.first(where: { $0.size == "mega" })?.text
        self.mega = URL(optionalString: megaString)
    }
}

