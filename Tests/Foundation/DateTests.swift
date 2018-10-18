//
//  DateTests.swift
//  ConvenientSwiftTests
//
//  Created by Artem Bobrov on 13/10/2018.
//

@testable import ConvenientSwift
import XCTest

class DateTests: XCTestCase {
    let date: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: "18/10/2016")!
    }()

    func testFromString() {
        XCTAssertEqual(date.string(with: "dd.MM.yy"), "18.10.16")
    }

    func testDateComponents() {
        XCTAssertEqual(date.year, 2016)
        XCTAssertEqual(date.day, 18)
        XCTAssertEqual(date.month, 10)
        XCTAssertEqual(date.weekday, 3)
        XCTAssert(date.isInPast)
    }

    func testDateChangingComponent() {
        let date: Date = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.date(from: "18/10/2018")!
        }()
        XCTAssertEqual(self.date.changing(.year, value: 2018), date)
    }
}
