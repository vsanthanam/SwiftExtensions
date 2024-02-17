// SwiftExtensions
// ArrayBuilder.swift
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

/// A result builder used to create arrays, as well as other types that can be represented by an array.
///
/// You can use this result builder to build any array, as well as any other type that conforms to `ArrayBuildable`
///
/// ```swift
/// @ArrayBuilder<[Int]>
/// func declarativeArray() -> [Int] {
///     1
///     2
///     3
///     someIntegerSequence
///     if foo {
///         4
///     } else {
///         5
///     }
///     for value in someIntegerSequence {
///         value + 1
///     }
/// }
/// ```
///
/// The result builder will acumulate all the values produced by each expression into a single array, and ultimately use that array to initialize an instance of the type used to specialize `ArrayBuilder`, in thise case `[Int]`.
@resultBuilder
public enum ArrayBuilder<Product: ArrayBuildable> {

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildExpression(_ expression: Product.ArrayElement) -> [Product.ArrayElement] {
        [expression]
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildExpression(_ expression: some Sequence<Product.ArrayElement>) -> [Product.ArrayElement] {
        .init(expression)
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildExpression(_ expression: Void) -> [Product.ArrayElement] {
        .init()
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildBlock(_ components: [Product.ArrayElement]...) -> [Product.ArrayElement] {
        components.flatMap { $0 }
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildPartialBlock(first: [Product.ArrayElement]) -> [Product.ArrayElement] {
        first
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildPartialBlock(accumulated: [Product.ArrayElement], next: [Product.ArrayElement]) -> [Product.ArrayElement] {
        accumulated + next
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildEither(first component: [Product.ArrayElement]) -> [Product.ArrayElement] {
        component
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildEither(second component: [Product.ArrayElement]) -> [Product.ArrayElement] {
        component
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildOptional(_ component: [Product.ArrayElement]?) -> [Product.ArrayElement] {
        component ?? .init()
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildArray(_ components: [[Product.ArrayElement]]) -> [Product.ArrayElement] {
        components.flatMap { $0 }
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildLimitedAvailability(_ component: [Product.ArrayElement]) -> [Product.ArrayElement] {
        component
    }

    /// Do not call this method. It is an implementation detail of the @ArrayBuilder result builder.
    public static func buildFinalResult(_ component: [Product.ArrayElement]) -> Product {
        Product(declaratively: component)
    }

}
