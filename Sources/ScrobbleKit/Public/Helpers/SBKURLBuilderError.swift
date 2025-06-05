//
//  SBKURLBuilderError.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 09/08/24.
//


/// Represents errors that can occur when building URLs with SBKURLBuilder.
public enum SBKURLBuilderError: Error {
    /// Indicates that the base URL for Last.fm is invalid.
    /// - This error should not occur under normal circumstances as the base URL is hardcoded.
    /// If you encounter this error:
    /// 1. Ensure you're using the latest version of the package.
    /// 2. If the error persists, please [file an issue on the package's GitHub repository](https://github.com/tfmart/ScrobbleKit/issues/new)
    ///    with details about your environment, package version, and how you're using the package.
    case badBaseURL
    
    /// Indicates that the generated URL is invalid.
    /// Solution: Verify the input parameters and ensure they don't contain characters that could make the URL invalid.
    case generatedBadURL
    
    /// Indicates that a parameter couldn't be properly encoded.
    /// Solution: Check the input string for any unusual characters and consider pre-processing the input to remove or replace problematic characters.
    case badParameter(String)
}
