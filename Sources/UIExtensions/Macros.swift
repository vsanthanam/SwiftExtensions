// SwiftExtensions
// Macros.swift
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

#if canImport(SwiftUI)
    import SwiftUI

    /// Create a SwiftUI Color from a hexidecimal string
    ///
    /// Properly formatted string should be prefixed with `#`, and contain exactly 6 or 8 characters
    ///
    /// ```swift
    /// var body: some View {
    ///     Text("Foo")
    ///         .foregroundStyle(#Color("#008080"))
    /// }
    /// ```
    @freestanding(expression)
    public macro Color(
        _ string: String
    ) -> SwiftUI.Color = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "SwiftUIColorStringMacro"
    )

    /// Create a SwiftUI Color from a hexidecimal integer
    ///
    /// Properly formatted integers should contain exactly 6 or 8 digits
    ///
    /// ```swift
    /// var body: some View {
    ///     Text("Foo")
    ///         .foregroundStyle(#Color(0x008080))
    /// }
    /// ```
    @freestanding(expression)
    public macro Color(
        _ integer: Int
    ) -> SwiftUI.Color = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "SwiftUIColorIntegerMacro"
    )

    /// Create a SwiftUI Image from an SF Symbol identifier
    ///
    /// The macro will produce a compiler error if an in valid identifeir is provided
    ///
    /// ```swift
    /// struct MyView: View {
    ///
    ///     var body: some View {
    ///         #Symbol("apple.terminal.fill")
    ///     }
    ///
    /// }
    /// ```
    @freestanding(expression)
    public macro Symbol(
        _ systemName: String
    ) -> SwiftUI.Image = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "SymbolMacro"
    )
#endif

#if canImport(UIKit)
    import UIKit

    /// Create a UIColor from a hexidecimal string
    ///
    /// Properly formatted string should be prefixed with `#`, and contain exactly 6 or 8 characters
    ///
    /// ```swift
    /// let color = #UIColor("#008080")
    /// ```
    @freestanding(expression)
    public macro UIColor(
        _ string: String
    ) -> UIKit.UIColor = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "UIColorStringMacro"
    )

    /// Create a UIColor from a hexidecimal integer
    ///
    /// Properly formatted integers should contain exactly 6 or 8 digits
    ///
    /// ```swift
    /// let color = #UIColor(0x008080)
    /// ```
    @freestanding(expression)
    public macro UIColor(
        _ integer: Int
    ) -> UIKit.UIColor = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "UIColorIntegerMacro"
    )
#endif

#if canImport(AppKit)
    import AppKit

    /// Create an NSColor from a hexidecimal string
    ///
    /// Properly formatted string should be prefixed with `#`, and contain exactly 6 or 8 characters
    ///
    /// ```swift
    /// let color = #NSColor("#008080")
    /// ```
    @freestanding(expression)
    public macro NSColor(
        _ string: String
    ) -> AppKit.NSColor = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "NSColorStringMacro"
    )

    /// Create an NSColor from a hexidecimal integer
    ///
    /// Properly formatted integers should contain exactly 6 or 8 digits
    ///
    /// ```swift
    /// let color = #NSColor(0x008080)
    /// ```
    @freestanding(expression)
    public macro NSColor(
        _ integer: Int
    ) -> AppKit.NSColor = #externalMacro(
        module: "UIExtensionsCompilerPlugin",
        type: "NSColorIntegergMacro"
    )
#endif
