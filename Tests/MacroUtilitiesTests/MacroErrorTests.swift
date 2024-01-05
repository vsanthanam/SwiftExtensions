// SwiftUtilities
// MacroErrorTests.swift
//
// MIT License
//
// Copyright (c) 2023 Varun Santhanam
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
//
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED  AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import MacroUtilities
import XCTest

final class MacroErrorTests: XCTestCase {

    func test_initializer() {
        let message = MacroError("My custom error message")
        XCTAssertEqual(message.reason, "My custom error message")
        XCTAssertEqual(message.errorDescription, "My custom error message")
        XCTAssertEqual(message.description, "My custom error message")
    }

    func test_exists_true() {
        let value: Bool? = false
        XCTAssertTrue(value.exists)
    }

    func test_exists_false() {
        let value: Bool? = nil
        XCTAssertFalse(value.exists)
    }

    func test_unwrap_throws() {
        let val: Bool? = nil
        XCTAssertThrowsError(try val.unwrap())
    }

    func test_unwrap_doesnt_throws() {
        let val: Bool? = false
        XCTAssertNoThrow(try val.unwrap())
    }

}
