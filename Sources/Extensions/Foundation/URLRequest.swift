//
//  URLRequest.swift
//  BetterSwift
//
//  Created by Artem Bobrov on 08/10/2018.
//

import Foundation

public extension URLRequest {
    /// Create URLRequest from URL string.
    ///
    /// - Parameter urlString: URL string to initialize URL request from.
    public init?(urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.init(url: url)
    }
}
