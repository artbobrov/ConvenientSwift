//
//  UISegmentedControl.swift
//  BetterSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import Foundation

public extension UISegmentedControl {
    /// Segments titles.
    public var segmentTitles: [String] {
        get {
            return (0 ..< numberOfSegments).compactMap { titleForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            newValue
                .enumerated()
                .forEach { self.insertSegment(withTitle: $0.element, at: $0.offset, animated: false) }
        }
    }

    /// Segments images.
    public var segmentImages: [UIImage] {
        get {
            return (0 ..< numberOfSegments).compactMap { imageForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            newValue
                .enumerated()
                .forEach { self.insertSegment(with: $0.element, at: $0.offset, animated: false) }
        }
    }
}
