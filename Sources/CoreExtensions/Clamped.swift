// SwiftExtensions
// Clamped.swift
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

/// A property wrapper that clamps values to a provided range
///
/// In the following example, values that exceed the range 0-10 will be clamped to the nearest value within the range
///
/// ```swift
/// struct MyStruct {
///
///     @Clamped(0...10)
///     var clampedValue: Int = 0
/// }
/// ```
@propertyWrapper
public struct Clamped<T: Comparable> {

    // MARK: - Initializers

    /// Create a clamped value
    /// - Parameters:
    ///   - wrappedValue: The initial value to wrap in the property wrapper
    ///   - range: The range used to clamp new values
    public init(
        initialValue wrappedValue: T,
        _ range: Range<T>
    ) {
        value = Self.clamp(wrappedValue, to: range)
        self.range = range
    }

    // MARK: - Property Wrapper

    /// The clamped value
    public var wrappedValue: T {
        get {
            value
        }
        set {
            value = Self.clamp(newValue, to: range)
        }
    }

    // MARK: - Private

    private var value: T
    private let range: Range<T>

    private static func clamp(_ value: T, to range: Range<T>) -> T {
        if range ~= value {
            value
        } else if value > range.upperBound {
            range.upperBound
        } else {
            range.lowerBound
        }
    }

}
