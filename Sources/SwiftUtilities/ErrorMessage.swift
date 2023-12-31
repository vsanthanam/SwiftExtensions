// SwiftUtilities
// ErrorMessage.swift
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

/// A reusable Swift `Error` with a message
public struct ErrorMessage: LocalizedError, CustomStringConvertible, Equatable, Hashable, Sendable {

    // MARK: - Initializers

    /// Create an error message
    ///
    /// Use this struct to throw an error without creating a dedicated `Error`-conforming type.
    ///
    /// ```swift
    /// throw ErrorMessage("Some message describing the error")
    /// ```
    ///
    /// - Parameters:
    ///   - message: The message to wrap in the error
    ///   - file: The file containing the call site where the error was initialized
    ///   - function: The function containing the call site where the error was initialized
    ///   - line: The line number of the call site where the error was initialized
    ///   - column: The column number of the call site where the error was initialized
    public init(
        _ message: String,
        file: StaticString = #fileID,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        self.message = message
        self.file = file
        self.function = function
        self.line = line
        self.column = column
    }

    // MARK: - API

    /// The error message
    public let message: String

    /// The file containing the call site where the error was initialized.
    public let file: StaticString

    /// The function containing the call site where the error was initialized.
    public let function: StaticString

    /// The line number of the call site where the error was initialized.
    public let line: UInt

    /// The column number of the call site where the error was initialized.
    public let column: UInt

    // MARK: - CustomStringConvertible

    @_documentation(visibility: internal)
    public var description: String {
        let components = [
            file.description,
            function.description,
            line.description,
            column.description,
            message
        ]
        return components
            .joined(separator: ":")
    }

    // MARK: - LocalizedError

    @_documentation(visibility: internal)
    public var errorDescription: String? { message }

    // MARK: - Hashable

    @_documentation(visibility: internal)
    public func hash(into hasher: inout Hasher) {
        hasher.combine(message)
        hasher.combine(file.description)
        hasher.combine(function.description)
        hasher.combine(line)
        hasher.combine(column)
    }

}

@_documentation(visibility: internal)
public func == (lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
    lhs.message == rhs.message && lhs.file.description == rhs.file.description && lhs.function.description == rhs.function.description && lhs.line == rhs.line && lhs.column == rhs.column
}
