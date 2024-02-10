// SwiftExtensions
// ColorExtensions.swift
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

#if canImport(SwiftUI) && canImport(UIKit)

    import SwiftUI
    import UIKit

    public extension Color {

        static func dynamic(light: Color, dark: Color) -> Color {
            .init(UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    UIColor(light)
                case .dark:
                    UIColor(dark)
                @unknown default:
                    UIColor(light)
                }
            })
        }

        static var label: Color {
            .init(.label)
        }

        static var secondaryLabel: Color {
            .init(.secondaryLabel)
        }

        static var tertiaryLabel: Color {
            .init(.tertiaryLabel)
        }

        static var quaternaryLabel: Color {
            .init(.quaternaryLabel)
        }

        static var placeholderText: Color {
            .init(.placeholderText)
        }

        static var tintColor: Color {
            .init(.tintColor)
        }

        static var systemBackground: Color {
            .init(.systemBackground)
        }

        static var secondarySystemBackground: Color {
            .init(.secondarySystemBackground)
        }

        static var tertiarySystemBackground: Color {
            .init(.tertiarySystemBackground)
        }

        static var systemGroupedBackground: Color {
            .init(.systemGroupedBackground)
        }

        static var secondarySystemGroupedBackground: Color {
            .init(.secondarySystemGroupedBackground)
        }

        static var tertiarySystemGroupedBackground: Color {
            .init(.tertiarySystemGroupedBackground)
        }

        static var separator: Color {
            .init(.separator)
        }

        static var opaqueSeparator: Color {
            .init(.opaqueSeparator)
        }

        static var link: Color {
            .init(.link)
        }

        static var lightText: Color {
            .init(.lightText)
        }

        static var darkText: Color {
            .init(.darkText)
        }

    }

#endif
