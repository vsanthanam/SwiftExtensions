// SwiftExtensions
// ArrayExtensions.swift
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

#endif

public extension Array {

    /// Safely subscript an array, returning an optional value if the provided index is out of bounds.
    /// - Parameter index: The index in the array to look up
    /// - Returns: The value at the provided index, or `nil` if the provided index is out of bounds
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }

    /// Safely subscript an array, returning a fallback value if the provided index is out of bounds.
    /// - Parameters:
    ///   - index: The index in the array to look up
    ///   - default: The value to use if the provided index is out of bounds
    /// - Returns: The value at the provided index, or the default value if the provided index is out of bounds
    subscript(
        _ index: Index,
        default defaultValue: @autoclosure () -> Element
    ) -> Element {
        self[safe: index] ?? defaultValue()
    }

    #if canImport(Foundation)

        /// Sort the array using a Swift key path in place
        /// - Parameters:
        ///   - keyPath: The keypath used to sort
        ///   - order: The sort order
        mutating func sort(
            by keyPath: KeyPath<Element, some Comparable>,
            order: SortOrder = .forward
        ) {
            self = sorted(by: keyPath, order: order)
        }

    #endif

    /// Create an array with all `nil` values removed
    /// - Returns: The filtered array without `nil` values
    func filterNils<T>() -> [T] where Element == T? {
        compactMap { value in value }
    }

    /// Create an array with all duplicates removed
    /// - Returns: The filtered array without duplicates
    func removingDuplicates() -> [Element] where Element: Hashable {
        var seen = Set<Element>()
        return filter { value in seen.insert(value).inserted }
    }
}
