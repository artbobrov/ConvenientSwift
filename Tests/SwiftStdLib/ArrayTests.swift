//
//  ArrayTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class ArrayTests: XCTestCase {
    func testArray() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.resized(10, fillWith: 0), [1, 2, 3, 4, 5, 0, 0, 0, 0, 0])

        let (odd, even) = array.binarySplit { $0 % 2 != 0 }
        XCTAssertTrue(odd.allSatisfy { $0 % 2 != 0 })
        XCTAssertTrue(even.allSatisfy { $0 % 2 == 0 })
    }

    func testBinarySearch() {
        let array = (0 ... 1_000_000).map { $0 }
        let toSearch = Int.random(in: 0 ... 1_000_000)
        XCTAssertEqual(array.binarySearch(by: toSearch), array.firstIndex(of: toSearch))
    }
}
