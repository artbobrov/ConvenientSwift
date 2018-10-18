//
//  String.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension String {
    /// Get letters count.
    public var lettersCount: Int {
        return unicodeScalars.count(where: { CharacterSet.letters.contains($0) })
    }

    /// Get deciaml digits count.
    public var decimalDigitsCount: Int {
        return unicodeScalars.count(where: { CharacterSet.decimalDigits.contains($0) })
    }

    /// Get whitespaces count.
    public var whitespacesCount: Int {
        return unicodeScalars.count(where: { CharacterSet.whitespaces.contains($0) })
    }
}

public extension String {
    /// String decoded from base64 (if applicable).
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }

    /// String encoded in base64 (if applicable).
    public var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
}

public extension String {
    /// Array of characters of a string.
    public var characters: [Character] {
        return Array(self)
    }

    /// A Boolean value that determines whether string contains any emoji.
    public var containEmoji: Bool {
        return contains(where: { $0.isEmoji })
    }

    /// A Boolean value that determines whether string contains any letters.
    public var hasLetters: Bool {
        return lettersCount > 0
    }

    /// A Boolean value that determines whether string contains of alphbetic characters.
    public var isAlphabetic: Bool {
        return lettersCount > 0 && decimalDigitsCount == 0
    }

    /// A Boolean value that determines whether email string is valid.
    public var isValidEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }

    /// A Boolean value that determines whether url string is valid.
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }

    /// A Boolean value that determines whether url string's scheme is valid.
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil
    }

    /// A Boolean value that determines whether url string's scheme is 'https'.
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }

    /// A Boolean value that determines whether url string's scheme is 'http'.
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }

    /// A Boolean value that determines whether file url string is valid.
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }

    /// A Boolean value that determines whether string contains of digits.
    public var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }

    /// Bool value from string (if applicable).
    public var bool: Bool? {
        switch trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "true", "1":
            return true
        case "false", "0":
            return false
        default:
            return nil
        }
    }

    /// A Boolean value that determines whether string contains of whitespaces.
    public var isWhitespace: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
}

#if canImport(UIKit)
    public extension String {
        /// A Boolean value that determines whether string is spelled correctly.
        public var isSpelledCorrectly: Bool {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: utf16.count)

            let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: Locale.preferredLanguages.first ?? "en")
            return misspelledRange.location == NSNotFound
        }
    }
#endif

public extension String {
    /// Returns a localized string, with an optional comment for translators.
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    /// Array with unicodes for all characters in a string.
    public var unicodeArray: [Int] {
        return unicodeScalars.map { Int($0.value) }
    }

    /// an array of all words in a string.
    public var words: [String] {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
}

public extension String {
    /// Safely subscript string with index.
    ///
    /// - Parameter index: Index.
    public subscript(safe index: Int) -> Character? {
        guard index.in(0 ..< count) else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }

    /// Safely subscript string within a half-open range.
    ///
    /// - Parameter range: Half-open range.
    public subscript(safe range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex),
            let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex ..< upperIndex])
    }

    /// Safely subscript string within a closed range.
    ///
    /// - Parameter range: Closed range.
    public subscript(safe range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex),
            let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex ..< upperIndex])
    }
}

public extension String {
    #if os(iOS) || os(macOS)
        /// Copy string to global pasteboard.
        public func copyToPasteboard() {
            #if os(iOS)
                UIPasteboard.general.string = self
            #elseif os(macOS)
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(self, forType: .string)
            #endif
        }
    #endif

    /// Check if string contains one or more instance of substring.
    ///
    /// - Parameters:
    ///   - string: Substring to search for.
    ///   - caseSensitive: Set true for case sensitive search (default is true).
    /// - Returns: True if string contains one or more instance of substring.
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }

    /// Count of substring in string.
    ///
    /// - Parameters:
    ///   - string: Substring to search for.
    ///   - caseSensitive: Set true for case sensitive search (default is true).
    /// - Returns: Count of appearance of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
}

public extension String {
    /// Repeat string multiple times.
    ///
    /// - Parameters:
    ///   - lhs: String to repeat.
    ///   - rhs: Number of times to repeat character.
    /// - Returns: New string with given string repeated n times.
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }

    /// Repeat string multiple times.
    ///
    /// - Parameters:
    ///   - lhs: Number of times to repeat character.
    ///   - rhs: String to repeat.
    /// - Returns: New string with given string repeated n times.
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: rhs, count: lhs)
    }
}
