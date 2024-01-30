// SwiftUtilities
// Casting.swift
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

/// Cast the provided value into the provided type
///
/// You can supply the desired type as an argument, or have the compiler infer it from the call site
///
/// ```swift
/// let val: SomeType = ...
/// let explicit = try cast(val, to: SomeOtherType.self) // Explicitly specify the type to cast to
/// let implicit: SomeOtherType = try cast(val) // Infer the type to cast to from the call site
/// ```
///
/// - Parameters:
///   - value: The value to cast
///   - type: The type to cast to
///   - message: The error message, if the cast fails
///   - file: The file containing the call site
///   - function: The function containing the call site
///   - line: The line number of the call site
///   - column: The column number of the call site
/// - Throws: An ``ErrorMessage`` if the provided cannot be cast
/// - Returns: The casted value
@discardableResult
public func cast<Target, Destination>(
    _ value: Target,
    to type: Destination.Type = Destination.self,
    message: @autoclosure () -> String? = nil,
    file: StaticString = #fileID,
    function: StaticString = #function,
    line: UInt = #line,
    column: UInt = #column
) throws -> Destination {
    guard let value = value as? Destination else {
        throw ErrorMessage(
            message() ?? "Could not cast value \(value) to type \(Destination.self)",
            file: file,
            function: function,
            line: line,
            column: column
        )
    }
    return value
}
