// SwiftExtensions
// ColorMacroProtocol.swift
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

public enum ColorInput {
    case integer
    case string
}

public enum ColorOutput {
    case swiftui
    case uikit
    case appkit
}

public protocol ColorMacroProtocol {
    static var input: ColorInput { get }
    static var output: ColorOutput { get }
    static var name: String { get }
}

public protocol UIKitColorMacro: ColorMacroProtocol {}
public protocol AppKitColorMacro: ColorMacroProtocol {}
public protocol SwiftUIColorMacro: ColorMacroProtocol {}
public protocol IntegerColorMacro: ColorMacroProtocol {}
public protocol StringColorMacro: ColorMacroProtocol {}

public extension ColorMacroProtocol {

    static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        switch input {
        case .string:
            guard case let .stringSegment(literal) = try node.argumentList.first?.expression
                .as(StringLiteralExprSyntax.self)?
                .segments.first
                .unwrap("#\(name) requires a single string literal expression") else {
                throw MacroError("#\(name) requires a single string literal expression")
            }

            let hex = literal.content.text.hasPrefix("#") ? String(literal.content.text.dropFirst()) : literal.content.text

            return try expression(for: hex)
        case .integer:
            let literal = try node.argumentList.first
                .unwrap("#\(name) requires a single integer literal expression")
                .expression.as(IntegerLiteralExprSyntax.self)
                .unwrap("#\(name) requires a single integer literal expression")
                .literal.text

            guard literal.hasPrefix("0x") else {
                throw MacroError("#\(name) requires a hexidecimal integer that must be prefixed with \"0x\"")
            }

            let hex = literal.dropFirst(2)

            return try expression(for: String(hex))
        }
    }

    private static func expression(for hex: String) throws -> ExprSyntax {
        guard (hex.count == 6 || hex.count == 8) else {
            throw MacroError("#\(name) requires a 6 or 8 digit hexidecimal value")
        }

        for character in hex {
            guard character.isHexDigit else {
                throw MacroError("\(hex) contains \(character), an illegal hexidecimal character")
            }
        }

        let components = try stride(from: 0, to: hex.count, by: 2)
            .map { index in
                let start = hex.index(hex.startIndex, offsetBy: index)
                let end = hex.index(start, offsetBy: 2)
                let value = String(hex[start ..< end])
                guard let int = UInt8(value, radix: 16) else {
                    throw MacroError()
                }
                return Double(int) / 255.0
            }

        switch output {
        case .swiftui:
            switch components.count {
            case 3:
                return "SwiftUI.Color(red: \(raw: components[0]), green: \(raw: components[1]), blue: \(raw: components[2]))"
            case 4:
                return "SwiftUI.Color(red: \(raw: components[0]), green: \(raw: components[1]), blue: \(raw: components[2]), opacity: \(raw: components[3]))"
            default:
                throw MacroError()
            }
        case .uikit:
            switch components.count {
            case 3:
                return "UIKit.UIColor(red: \(raw: components[0]), green: \(raw: components[1]), blue: \(raw: components[2]))"
            case 4:
                return "UIKit.UIColor(red: \(raw: components[0]), green: \(raw: components[1]), blue: \(raw: components[2]), alpha: \(raw: components[3]))"
            default:
                throw MacroError()
            }
        case .appkit:
            switch components.count {
            case 3:
                return "AppKit.NSColor(red: \(raw: components[0]), green: \(raw: components[1]), blue: \(raw: components[2]), alpha: 1.0)"
            case 4:
                return "AppKit.NSColor(red: \(raw: components[0]), green: \(raw: components[1]), blue: \(raw: components[2]), alpha: \(raw: components[3]))"
            default:
                throw MacroError()
            }
        }
    }
}

public extension SwiftUIColorMacro {
    static var output: ColorOutput { .swiftui }
    static var name: String { "Color" }
}

public extension UIKitColorMacro {
    static var output: ColorOutput { .uikit }
    static var name: String { "UIColor" }
}

public extension AppKitColorMacro {
    static var output: ColorOutput { .appkit }
    static var name: String { "NSColor" }
}

public extension IntegerColorMacro {
    static var input: ColorInput { .integer }
}

public extension StringColorMacro {
    static var input: ColorInput { .string }
}
