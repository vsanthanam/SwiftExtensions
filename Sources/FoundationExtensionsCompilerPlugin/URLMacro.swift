// SwiftExtensions
// URLMacro.swift
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

import Foundation
import MacroExtensions
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct URLMacro: ExpressionMacro {

    // MARK: - ExpressionMacro

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard case let .stringSegment(literal) = try node.argumentList.first?.expression
            .as(StringLiteralExprSyntax.self)?
            .segments.first
            .unwrap("#URL requires a single string literal expression") else {
            throw MacroError("#URL requires a single string literal expression")
        }
        if let argument = node.argumentList.dropFirst().first?.expression.as(BooleanLiteralExprSyntax.self)?.literal,
           argument.tokenKind == .keyword(.false) {
            return try "URL(string: \"\(raw: evaluate(literal.content.text))\")!"
        } else {
            return try "URL(string: \"\(raw: strictlyEvaluate(literal.content.text))\")!"
        }

    }

    // MARK: - Private

    private static func strictlyEvaluate(_ string: String) throws -> String {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        guard let match = detector.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count)),
              match.range.length == string.utf16.count else {
            throw MacroError("\"\(string)\" is not a valid URL")
        }
        return string
    }

    private static func evaluate(_ string: String) throws -> String {
        guard URL(string: string) != nil else {
            throw MacroError("\"\(string)\" is not a valid URL")
        }
        return string
    }

}
