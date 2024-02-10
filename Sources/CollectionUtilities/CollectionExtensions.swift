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

#if canImport(Foundation)

    import Foundation

    public extension Collection {

        /// Sort the collection using a Swift key path
        ///
        /// The KeyPath's `Value` must conform to `Comparable`
        ///
        /// ```swift
        /// struct Score: CustomStringConvertible {
        ///     let value: Int
        ///     var description: String { value.description }
        /// }
        ///
        /// let scores = [Score(value: 12), Score(value: 1), Score(value: 19)]
        /// let sorted = scores.sorted(by: \.value)
        /// print(sorted) // Prints ["1", "12", "19"]
        ///
        /// ```
        ///
        /// - Parameters:
        ///   - keyPath: key path
        ///   - order: The sort order
        /// - Returns: An array containing the sorted collection
        func sorted(
            by keyPath: KeyPath<Element, some Comparable>,
            order: SortOrder = .forward
        ) -> [Element] {
            switch order {
            case .forward:
                sorted { lhs, rhs in
                    lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
                }
            case .reverse:
                sorted { lhs, rhs in
                    lhs[keyPath: keyPath] > rhs[keyPath: keyPath]
                }
            }
        }

    }

#endif
