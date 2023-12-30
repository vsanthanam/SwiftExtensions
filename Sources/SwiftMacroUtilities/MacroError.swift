// SwiftUtilities
// MacroError.swift
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

/// An error used to indicate the failure of a Swift Macro expansion
public struct MacroError: LocalizedError, CustomStringConvertible {

    // MARK: - Initializers

    /// Create a macro error with a failure reason message
    /// - Parameter reason: The message to use
    public init(_ reason: String = "Macro expansion failed.") {
        self.reason = reason
    }

    // MARK: - API

    /// A string describing the reason that the macro expansion failed.
    public let reason: String

    // MARK: - CustomStringConvertible

    @_documentation(visibility: internal)
    public var description: String { reason }

    // MARK: - LocalizedError

    @_documentation(visibility: internal)
    public var errorDescription: String? { reason }

}

public extension Optional {

    /// Whether or not the optional contains a value
    ///
    /// Returns `true` if the optional contains a value, otherwise `false`
    var exists: Bool {
        switch self {
        case .some:
            true
        case .none:
            false
        }
    }

    /// Unwraps the optional, or throws an error if the optional is `.none`
    ///
    /// This can be useful when using SwiftSyntax's  `as<T>(_ type:)` methods:
    ///
    /// ```swift
    /// let declaration = try token
    ///     .as(StructDeclSyntax.self)
    ///     .mustExist("Macro expected a struct")
    /// ```
    ///
    /// - Parameter message: The message to use in the error, if the optional doesn't contain a valie
    /// - Returns: The unwrapped optional
    /// - Throws: A ``MacroError``, if the optional doesn't contain a value.
    @discardableResult
    func mustExist(
        _ message: String = "Macro expansion failed."
    ) throws -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            throw MacroError(message)
        }
    }

}
