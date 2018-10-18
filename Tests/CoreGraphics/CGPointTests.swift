//
//  CGPointTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class CGPointTests: XCTestCase {
    func testPointDistance() {
        let lhs = CGPoint.zero
        let rhs = CGPoint(x: 3, y: 4)
        XCTAssertEqual(lhs.distance(to: rhs), 5)
    }

    func testAngleConverting() {
        XCTAssertEqual(CGFloat.pi.radiansToDegrees, 180)
        XCTAssertEqual(CGFloat(180).degreesToRadians, CGFloat.pi)
    }
}
