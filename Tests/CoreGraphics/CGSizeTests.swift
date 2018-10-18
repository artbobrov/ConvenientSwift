//
//  CGSizeTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class CGSizeTests: XCTestCase {
    func testSizeAspectFit() {
        let size = CGSize(width: 200, height: 100)
        XCTAssertEqual(size.aspectFit(to: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 50), "")
    }

    func testSizeAspectFill() {
        let size = CGSize(width: 212, height: 80)

        XCTAssertEqual(size.aspectFill(to: CGSize(width: 100, height: 100)), CGSize(width: 265, height: 80), "")
    }

    func testSizeScalarOperators() {
        XCTAssertEqual(CGSize(width: 100, height: 100) * 0.5, CGSize(width: 50, height: 50), "")

        var size = CGSize(width: 100, height: 100)
        size *= 0.5
        XCTAssertEqual(size, CGSize(width: 50, height: 50), "")
    }
}
