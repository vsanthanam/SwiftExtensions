// SwiftExtensions
// URLMacros.swift
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

#if canImport(Foundation)

    import Foundation

    /// Create a URL from a string literal without an optional
    ///
    /// Use this macro to validate your string literal URL at compile time and safely unwrap the `URL?` created by the initializer.
    ///
    /// ```swift
    /// let url = #URL("https://www.apple.com")
    /// ```
    ///
    /// Expands to
    ///
    /// ```swift
    /// let url = URL(string: "https://www.apple.com")!
    /// ```
    ///
    /// The forced unwrapping in the expanded code is gauranteed to never fail, because the macro validates the string literal at compile time and produces a diagnostic if the provide string is not a valid URL
    ///
    /// - Parameters:
    ///   - value: A literal string to convert into a `URL`
    ///   - strict: Whether or not the string should be evaluated strictly. When `true`, the macro performs additional validation beyond just ensuring that the unwrapping will not fail.
    /// - Returns: A `URL` based on the provided string literal
    @freestanding(expression)
    public macro URL(
        _ value: String,
        strict: Bool = true
    ) -> URL = #externalMacro(module: "FoundationExtensionsCompilerPlugin", type: "URLMacro")

    /// Validate a string to ensure that it is a legal URL
    ///
    /// The macro makes no alterations to the provided string, but will produce a compile time error of the provided string isn't a legal URL
    ///
    /// ```swift
    /// let str1 = #URLString("https://www.apple.com") // will compile
    /// let str2 = #URLString("p1i3ngp2io4unvp2inrg") // will not compile
    /// ```
    @freestanding(expression)
    public macro URLString(
        _ value: String
    ) -> String = #externalMacro(module: "FoundationExtensionsCompilerPlugin", type: "URLStringMacro")

#endif
