// SwiftExtensions
// SymbolMacro.swift
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

import MacroExtensions
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public struct SymbolMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard case let .stringSegment(literal) = try node.argumentList.first?.expression
            .as(StringLiteralExprSyntax.self)?
            .segments.first
            .unwrap("#Symbol requires a single string literal expression") else {
            throw MacroError("#Symbol requires a single string literal expression")
        }

        try validateSymbol(literal.content.text)

        return "Image(systemName: \"\(raw: literal.content.text)\")"
    }

    private static func validateSymbol(_ string: String) throws {
        #if canImport(UIKit)
            if UIImage(systemName: string) == nil {
                throw MacroError("\(string) is not a valid symbol identifier")
            }
        #elseif canImport(AppKit)
            if NSImage(systemSymbolName: string, accessibilityDescription: nil) == nil {
                throw MacroError("\(string) is not a valid symbol identifier")
            }
        #else
            throw MacroError("Macro not supported")
        #endif
    }
}
