// SwiftUtilities
// URLMacroTests.swift
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

import SwiftSyntaxMacrosTestSupport
import SwiftUtilities
import SwiftUtilitiesCompilerPlugin
import XCTest

final class URLMacroTest: XCTestCase {

    func test_url_macro_valid() {
        assertMacroExpansion(
            """
            #URL("23489fjpoasfljkn134lkjnj.a,1984pj", strict: false)
            """,
            expandedSource:
            """
            URL(string: "23489fjpoasfljkn134lkjnj.a,1984pj")!
            """,
            macros: [
                "URL": URLMacro.self
            ]
        )
    }

    func test_url_macro_valid_strict() {
        assertMacroExpansion(
            """
            #URL("https://www.apple.com")
            """,
            expandedSource:
            """
            URL(string: "https://www.apple.com")!
            """,
            macros: [
                "URL": URLMacro.self
            ]
        )
    }

    func test_url_macro_not_literal() {
        assertMacroExpansion(
            """
            var x = "https://www.apple.com"
            #URL(plop)
            """,
            expandedSource:
            """
            var x = "https://www.apple.com"
            #URL(plop)
            """,
            diagnostics: [
                .init(
                    message: "#URL requires a single string literal expression",
                    line: 2,
                    column: 1
                )
            ],
            macros: [
                "URL": URLMacro.self
            ]
        )
    }

    func test_url_macro_invalid_literal() {
        assertMacroExpansion(
            """
            #URL("", strict: false)
            """,
            expandedSource:
            """
            #URL("", strict: false)
            """,
            diagnostics: [
                .init(
                    message: "\"\" is not a valid URL",
                    line: 1,
                    column: 1
                )
            ],
            macros: [
                "URL": URLMacro.self
            ]
        )
    }

    func test_url_macro_invalid_literal_strict() {
        assertMacroExpansion(
            """
            #URL("23489fjpoasfljkn134lkjnj.a,1984pj")
            """,
            expandedSource:
            """
            #URL("23489fjpoasfljkn134lkjnj.a,1984pj")
            """,
            diagnostics: [
                .init(
                    message: "\"23489fjpoasfljkn134lkjnj.a,1984pj\" is not a valid URL",
                    line: 1,
                    column: 1
                )
            ],
            macros: [
                "URL": URLMacro.self
            ]
        )
    }

}
