// SwiftUtilities
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

    @freestanding(expression)
    public macro Color(_ string: String) -> SwiftUI.Color = #externalMacro(module: "SwiftUtilitiesCompilerPlugin", type: "ColorStringMacro")

    @freestanding(expression)
    public macro Color(_ integer: Int) -> SwiftUI.Color = #externalMacro(module: "SwiftUtilitiesCompilerPlugin", type: "ColorIntegerMacro")

#endif

#if canImport(UIKit)
    import UIKit

    @freestanding(expression)
    public macro UIColor(_ string: String) -> UIKit.UIColor = #externalMacro(module: "SwiftUtilitiesCompilerPlugin", type: "UIColorStringMacro")

    @freestanding(expression)
    public macro UIColor(_ integer: Int) -> UIKit.UIColor = #externalMacro(module: "SwiftUtilitiesCompilerPlugin", type: "UIColorIntegerMacro")
#endif

#if canImport(AppKit)
    import AppKit

    @freestanding(expression)
    public macro NSColor(_ string: String) -> AppKit.NSColor = #externalMacro(module: "SwiftUtilitiesCompilerPlugin", type: "NSColorStringMacro")

    @freestanding(expression)
    public macro NSColor(_ integer: Int) -> AppKit.NSColor = #externalMacro(module: "SwiftUtilitiesCompilerPlugin", type: "NSColorIntegergMacro")
#endif
