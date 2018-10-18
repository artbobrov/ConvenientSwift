//
//  OptionalsTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class OptionalsTests: XCTestCase {
    func testOptionals() {
        let value: Int? = nil
        XCTAssertNil(value)
        value.run { _ in
            XCTFail("value is nil, `run` shouldn't run block")
        }

        XCTAssertTrue(value.isNil)
        XCTAssertEqual(value.unwrapped(or: -1), -1)
        XCTAssertThrowsError(try value.unwrapped(or: NSError()))
    }
}
