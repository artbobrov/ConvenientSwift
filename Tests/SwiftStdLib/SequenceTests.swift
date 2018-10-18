//
//  SequenceTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class SequenceTests: XCTestCase {
    func testSequence() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.accumulate(initial: 0, next: +), [1, 3, 6, 10, 15])
        XCTAssertFalse(array.contains(1, 2, 6, 7))
        XCTAssertFalse(array.hasDuplicates)
        XCTAssertEqual(array.sum(), 15)
    }
}
