// SwiftExtensions
// ArrayBuilderTests.swift
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

import CollectionExtensions
import XCTest

final class ArrayBuilderTests: XCTestCase {

    let o = true
    let list = [4, 5, 6]
    let cool: String? = nil
    let notCool: String? = "bar"

    @ArrayBuilder<[Int]>
    var testArray: [Int] {
        1
        2
        3
        list
        for item in list {
            item + 1
        }
        if o {
            10
        } else {
            11
        }
        if let cool {
            cool.count
        }
        if let notCool {
            notCool.count
        }
    }

    func test_array_builder() {
        let expected = [1, 2, 3, 4, 5, 6, 5, 6, 7, 10, 3]
        XCTAssertEqual(testArray, expected)
    }

}
