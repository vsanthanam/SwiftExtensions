// SwiftUtilities
// ErrorMessageTests.swift
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

import CoreUtilities
import XCTest

final class ErrorMessageTests: XCTestCase {

    func test_initializer() {
        let message = ErrorMessage("My custom error message")
        XCTAssertEqual(message.message, "My custom error message")
        XCTAssertEqual(message.errorDescription, "My custom error message")
        XCTAssertEqual(message.file.description, "CoreUtilitiesTests/ErrorMessageTests.swift")
        XCTAssertEqual(message.function.description, "test_initializer()")
        XCTAssertEqual(message.line, 32)
        XCTAssertEqual(message.column, 35)
    }

    func test_description() {
        let message = ErrorMessage("New message")
        XCTAssertEqual(message.description, "CoreUtilitiesTests/ErrorMessageTests.swift:test_description():42:35:New message")
    }

    func test_equatable() {
        let message1 = ErrorMessage("Foo", file: "Bar", function: "Baz", line: 12, column: 24)
        let message2 = ErrorMessage("Foo", file: "Bar", function: "Baz", line: 12, column: 24)
        XCTAssertEqual(message1, message2)
    }

    func test_hashable() {
        let message = ErrorMessage("Hashable")
        var dictionary = [ErrorMessage: String]()
        dictionary[message] = "foo"
        XCTAssertEqual(dictionary[message], "foo")
    }
}
