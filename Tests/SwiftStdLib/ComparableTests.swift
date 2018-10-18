//
//  ComparableTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class ComparableTests: XCTestCase {
    func testComparable() {
        XCTAssertTrue(5.in(0 ... 10))
        XCTAssertFalse(5.in(0 ..< 5))
        XCTAssertEqual(10.clamped(to: 0 ... 5), 5)
        XCTAssertEqual(1.clamped(to: 2 ... 5), 2)
    }
}
