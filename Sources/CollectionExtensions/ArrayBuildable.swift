// SwiftExtensions
// ArrayBuildable.swift
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

/// A protocol that types which can be built using the ``ArrayBuilder`` DSL must conform to
///
/// If a type conforms to this protocol, it can be built using the @ArrayBuilder result builder.
public protocol ArrayBuildable<ArrayElement> {

    /// The element of the array used to build the type
    associatedtype ArrayElement

    /// Create an instance of the type using a declaratively built array
    /// - Parameter array: The array used to build type
    init(declaratively array: [ArrayElement])
}

extension Array: ArrayBuildable {
    public init(declaratively array: [Element]) {
        self = array
    }
}
