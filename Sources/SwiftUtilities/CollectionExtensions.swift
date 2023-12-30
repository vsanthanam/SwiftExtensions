// SwiftUtilities
// CollectionExtensions.swift
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

extension Collection {

    /// Sort the collection using a key path
    /// - Parameters:
    ///   - keyPath: key path
    ///   - order: The sort order
    /// - Returns: An array containing the sorted collection
    func sorted<T>(
        by keyPath: KeyPath<Element, T>,
        order: SortOrder = .forward
    ) -> [Element] where T: Comparable {
        switch order {
        case .forward:
            return sorted { lhs, rhs in
                lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
            }
        case .reverse:
            return sorted { lhs, rhs in
                lhs[keyPath: keyPath] > rhs[keyPath: keyPath]
            }
        }
    }

}

public extension Array {

    /// Safely subscript an array, returning an optional value if the provided index is out of bounds.
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }

    /// Create an array of optional values
    /// - Returns: The array containing the same values, as optionals
    func toOptional() -> [Element?] {
        self
    }

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

public extension Set {

    /// Create a set of optional values
    /// - Returns: The set of optional values
    func toOptional() -> Set<Element?> {
        self
    }
}
