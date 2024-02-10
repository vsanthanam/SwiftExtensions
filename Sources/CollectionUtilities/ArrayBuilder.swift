// SwiftUtilities
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

@resultBuilder
public enum ArrayBuilder<Product: ArrayBuildable> {

    public static func buildExpression(_ expression: Product.Element) -> [Product.Element] {
        [expression]
    }

    public static func buildExpression(_ expression: some Sequence<Product.Element>) -> [Product.Element] {
        .init(expression)
    }

    public static func buildExpression(_ expression: Void) -> [Product.Element] {
        .init()
    }

    public static func buildBlock(_ components: [Product.Element]...) -> [Product.Element] {
        components.flatMap { $0 }
    }

    public static func buildPartialBlock(first: [Product.Element]) -> [Product.Element] {
        first
    }

    public static func buildPartialBlock(accumulated: [Product.Element], next: [Product.Element]) -> [Product.Element] {
        accumulated + next
    }

    public static func buildEither(first component: [Product.Element]) -> [Product.Element] {
        component
    }

    public static func buildEither(second component: [Product.Element]) -> [Product.Element] {
        component
    }

    public static func buildOptional(_ component: [Product.Element]?) -> [Product.Element] {
        component ?? .init()
    }

    public static func buildArray(_ components: [[Product.Element]]) -> [Product.Element] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: [Product.Element]) -> [Product.Element] {
        component
    }

    public static func buildFinalResult(_ component: [Product.Element]) -> Product {
        Product(declaratively: component)
    }

}
