//
//  CharacterTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class CharacterTests: XCTestCase {
    func testCharacter() {
        let chars: [Character] = ["😀", "1", "a", "A", " "]

        XCTAssertTrue(chars[0].isEmoji)
        XCTAssertTrue(chars[1].isNumber)
        XCTAssertTrue(chars[2].isLowercased)
        XCTAssertTrue(chars[3].isLetter)
        XCTAssertTrue(chars[3].isUppercased)
        XCTAssertTrue(chars[4].isWhiteSpace)
    }
}
