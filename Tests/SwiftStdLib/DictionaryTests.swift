//
//  DictionaryTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class DictionaryTests: XCTestCase {
    func testDictionaryKeys() {
        var dict = [
            "one": "some",
            "two": "some",
            "three": "some"
        ]
        XCTAssertTrue(dict.has(key: "one"))
        dict.removeAll(keys: ["one", "two"])
        XCTAssertFalse(dict.has(key: "one"))
        XCTAssertFalse(dict.has(key: "two"))
    }

    func testDictionaryValues() {
        var dict = [
            "ONE": "some",
            "TWO": "some",
            "THREE": "some"
        ]
        dict.lowercaseAllKeys()
        XCTAssertEqual(Set(dict.keys(forValue: "some")), Set(["one", "two", "three"]))
    }
}
