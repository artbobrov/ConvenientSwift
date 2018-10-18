//
//  URLTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class URLTests: XCTestCase {
    func testURLMimeType() {
        XCTAssertEqual(URL(string: "/home/image.png")!.mimeType, "image/png")
        XCTAssertEqual(URL(string: "/home/text.txt")!.mimeType, "text/plain")
    }
}
