//
//  ArrayTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class ArrayTests: XCTestCase {
    func testDivided() {
        let array = [1, 2, 3, 4, 5]
        let (odd, even) = array.divided { $0 % 2 != 0 }
        XCTAssertTrue(odd.allSatisfy { $0 % 2 != 0 })
        XCTAssertTrue(even.allSatisfy { $0 % 2 == 0 })
    }

    func testBinarySearch() {
        let array = (0 ... 1_000_000).map { $0 }
        let toSearch = Int.random(in: 0 ... 1_000_000)
        XCTAssertEqual(array.binarySearch(by: toSearch), array.firstIndex(of: toSearch))
    }
}
