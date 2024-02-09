// SwiftUtilities
// ArrayExtensionsTests.swift
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

import CollectionUtilities
import XCTest

final class ArrayExtensionsTests: XCTestCase {

    func test_filterNils() {
        let array = [12, nil, 16, 1, nil, -5, 19]
        XCTAssertEqual(array.filterNils(), [12, 16, 1, -5, 19])
    }

    func test_removeDuplicates() {
        let array = [12, 19, 19, 1, 16, 1, 16, -1]
        XCTAssertEqual(array.removingDuplicates(), [12, 19, 1, 16, -1])
    }

    func test_sort() {
        var array = [12, 19, 19, 1, 16, 1, 16, -1]
        array.sort(by: \.self, order: .forward)
        XCTAssertEqual(array, [-1, 1, 1, 12, 16, 16, 19, 19])
    }

    func test_sort_reverse() {
        var array = [12, 19, 19, 1, 16, 1, 16, -1]
        array.sort(by: \.self, order: .reverse)
        XCTAssertEqual(array, [19, 19, 16, 16, 12, 1, 1, -1])
    }

    func test_safe_index_legal() {
        let array = [12, 19, 19, 1, 16, 1, 16, -1]
        XCTAssertEqual(array[safe: 6], 16)
    }

    func test_safe_index_out_of_bonuds() {
        let array = [12, 19, 19, 1, 16, 1, 16, -1]
        XCTAssertEqual(array[safe: 8], nil)
    }

    func test_safe_fallback() {
        let array = ["foo", "bar", "foo", "bar"]
        XCTAssertEqual(array[2, default: "baz"], "foo")
    }

    func test_safe_fallback_out_of_bounds() {
        let array = ["foo", "bar", "foo", "bar"]
        XCTAssertEqual(array[4, default: "baz"], "baz")
    }
}
