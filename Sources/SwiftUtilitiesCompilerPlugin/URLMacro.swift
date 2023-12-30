// SwiftUtilities
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
import SwiftCompilerPlugin
import SwiftMacroUtilities
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct URLMacro: ExpressionMacro {

    public static func expansion<Node, Context>(
        of node: Node,
        in context: Context
    ) throws -> ExprSyntax where Node: FreestandingMacroExpansionSyntax, Context: MacroExpansionContext {
        let segment = try node.argumentList.first
            .mustExist("#URL requires a single string literal expression")
            .expression
            .as(StringLiteralExprSyntax.self)
            .mustExist("#URL requires a single string literal expression")
            .segments.first
            .mustExist("#URL requires a single string literal expression")
        guard case let .stringSegment(literal) = segment else {
            throw MacroError("#URL requires a single string literal expression")
        }
        guard URL(string: literal.content.text) != nil else {
            throw MacroError("\"\(literal.content.text)\" is not a valid URL")
        }
        return "URL(string: \"\(raw: literal.content.text)\")!"
    }

}
