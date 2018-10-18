//
//  URL.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

#if canImport(MobileCoreServices)
    import MobileCoreServices

    public extension URL {
        /// Gets MIME type of file URL.
        public var mimeType: String? {
            let ext = pathExtension
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)?.takeRetainedValue() else { return nil }
            return UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() as String?
        }
    }
#endif
public extension URL {
    /// Dictionary of the URL's query parameters.
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }

        var items: [String: String] = [:]

        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }

        return items
    }
}

public extension URL {
    /// URL with appending query parameters.
    ///
    /// - Parameter parameters: Parameters dictionary.
    /// - Returns: URL with appending given query parameters.
    public func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }

    /// Append query parameters to URL.
    ///
    /// - Parameter parameters: Parameters dictionary.
    public mutating func appendQueryParameters(_ parameters: [String: String]) {
        self = appendingQueryParameters(parameters)
    }

    /// Get value of a query key.
    ///
    /// - Parameter key: The key of a query value.
    /// - Returns: String value by given key if exists.
    public func queryValue(for key: String) -> String? {
        let stringURL = absoluteString
        guard let items = URLComponents(string: stringURL)?.queryItems else { return nil }
        for item in items where item.name == key {
            return item.value
        }
        return nil
    }

    /// Returns a new URL by removing all the path components.
    ///
    /// - Returns: URL with all path components removed.
    public func deletingAllPathComponents() -> URL {
        var url: URL = self
        for _ in 0 ..< pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }

    /// Remove all the path components from the URL.
    public mutating func deleteAllPathComponents() {
        for _ in 0 ..< pathComponents.count - 1 {
            deleteLastPathComponent()
        }
    }

    /// Generates new URL that does not have scheme.
    ///
    /// - Returns: New URL without scheme.
    public func droppedScheme() -> URL? {
        if let scheme = self.scheme {
            let droppedScheme = String(absoluteString.dropFirst(scheme.count + 3))
            return URL(string: droppedScheme)
        }

        guard host != nil else { return self }

        let droppedScheme = String(absoluteString.dropFirst(2))
        return URL(string: droppedScheme)
    }
}
