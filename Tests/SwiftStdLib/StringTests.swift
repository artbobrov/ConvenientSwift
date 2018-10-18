//
//  StringTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class StringTests: XCTestCase {
    func testString() {
        let email = "artembobrov3059@gmail.com"
        XCTAssertTrue(email.isValidEmail)
        XCTAssertFalse(email.containEmoji)
        XCTAssertTrue(email.hasLetters)
        XCTAssertEqual(email.decimalDigitsCount, 4)

        let string = "some text sample"
        XCTAssertEqual(string.words.count, 3)
        XCTAssertTrue(string.isAlphabetic)
    }
}
