// SwiftExtensions
// URLStringMacroTests.swift
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

import FoundationExtensions
import FoundationExtensionsCompilerPlugin
import SwiftSyntaxMacrosTestSupport
import XCTest

final class URLStringMacroTest: XCTestCase {

    func test_url_macro_valid() {
        assertMacroExpansion(
            """
            let x = #URLString("https://www.apple.com")
            """,
            expandedSource:
            """
            let x = "https://www.apple.com"
            """,
            macros: [
                "URLString": URLStringMacro.self
            ]
        )
    }

    func test_url_macro_not_literal() {
        assertMacroExpansion(
            """
            let x = "https://www.apple.com"
            let y = #URLString(x)
            """,
            expandedSource:
            """
            let x = "https://www.apple.com"
            let y = #URLString(x)
            """,
            diagnostics: [
                .init(
                    message: "#URLString requires a single string literal expression",
                    line: 2,
                    column: 9
                )
            ],
            macros: [
                "URLString": URLStringMacro.self
            ]
        )
    }

    func test_url_macro_invalid() {
        assertMacroExpansion(
            """
            let x = #URLString("p29u3n5fp23bgp")
            """,
            expandedSource:
            """
            let x = #URLString("p29u3n5fp23bgp")
            """,
            diagnostics: [
                .init(
                    message: "\"p29u3n5fp23bgp\" is not a valid URL",
                    line: 1,
                    column: 9
                )
            ],
            macros: [
                "URLString": URLStringMacro.self
            ]
        )
    }

}
