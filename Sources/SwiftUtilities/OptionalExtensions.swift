// SwiftUtilities
// OptionalExtensions.swift
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

public extension Optional {

    /// Returns `true` if the optional contains a value, otherwise `false`
    ///
    /// Use this in place of a null check.
    ///
    /// ```swift
    /// let value: String?
    ///
    /// func doSomething() -> Bool {
    ///     return value != nil
    /// }
    /// ```
    ///
    /// Can be written as
    ///
    /// ```swift
    /// let value: String?
    ///
    /// func doSomething() -> Bool {
    ///     return value.exists
    /// }
    /// ```
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
    /// ```swift
    /// let value: Bool? = nil
    /// do {
    ///     let bool = try value.mustExist("A required value was null")
    /// } catch {
    ///     // Handle error
    /// }
    /// ```
    /// - Parameters:
    ///   - message: The message to use if the optional is nil
    ///   - file: The file containing the call site
    ///   - function: The function containing the call site
    ///   - line: The line number of the call site
    ///   - column: The column number of the call site
    /// - Returns: The unwrapped optional
    /// - Throws: An ``ErrorMessage``, if the optional is `.none`
    @discardableResult
    func mustExist(
        _ message: String,
        file: StaticString = #fileID,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) throws -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            throw ErrorMessage(
                message,
                file: file,
                function: function,
                line: line,
                column: column
            )
        }
    }
}
