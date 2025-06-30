//
//  MyCalculatorTests.swift
//  MyCalculatorTests
//
//  Created by Dhaval Bhadania on 30/06/25.
//

import Testing
@testable import MyCalculator
//
//struct MyCalculatorTests {
//
//    @Test func example() async throws {
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }
//
//}


import XCTest
@testable import MyCalculator

final class StringCalculatorTests: XCTestCase {

    var calculator: StringCalculator!

    override func setUp() {
        super.setUp()
        calculator = StringCalculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    func testEmptyStringReturnsZero() throws {
        XCTAssertEqual(try calculator.add(""), 0)
    }

    func testSingleNumberReturnsSameNumber() throws {
        XCTAssertEqual(try calculator.add("5"), 5)
    }

    func testTwoNumbersCommaSeparated() throws {
        XCTAssertEqual(try calculator.add("1,2"), 3)
    }

    func testMultipleNumbers() throws {
        XCTAssertEqual(try calculator.add("1,2,3,4"), 10)
    }

    func testNumbersWithNewlineSeparator() throws {
        XCTAssertEqual(try calculator.add("1\n2,3"), 6)
    }

    func testCustomDelimiter() throws {
        XCTAssertEqual(try calculator.add("//;\n1;2"), 3)
    }

    func testNegativeNumberThrowsError() {
        XCTAssertThrowsError(try calculator.add("1,-2,3")) { error in
            guard let err = error as? StringCalculator.CalculatorError else {
                return XCTFail("Unexpected error type")
            }

            switch err {
            case .negativeNumbersNotAllowed(let negatives):
                XCTAssertEqual(negatives, [-2])
            }
        }
    }

    func testMultipleNegativeNumbersThrowsAllInError() {
        XCTAssertThrowsError(try calculator.add("1,-2,-4")) { error in
            guard let err = error as? StringCalculator.CalculatorError else {
                return XCTFail("Unexpected error type")
            }

            switch err {
            case .negativeNumbersNotAllowed(let negatives):
                XCTAssertEqual(negatives, [-2, -4])
            }
        }
    }
}

