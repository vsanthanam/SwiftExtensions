// SwiftExtensions
// TaskGroupExtensions.swift
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

import CollectionExtensions
import CoreExtensions

@inlinable
public func race<T>(
    @ArrayBuilder <[@Sendable () async throws -> T]> between operations: () -> [@Sendable () async throws -> T]
) async throws -> T where T: Sendable {
    try await withThrowingTaskGroup(
        of: T.self
    ) { group in
        for operation in operations() {
            group.addTask(operation: operation)
        }
        do {
            for try await value in group {
                group.cancelAll()
                return value
            }
        } catch {
            group.cancelAll()
            throw error
        }
        throw ErrorMessage("No operations provided")
    }
}

@available(
    macOS 13.0,
    iOS 16.0,
    tvOS 16.0,
    watchOS 8.0,
    macCatalyst 15.0, *
)
@inlinable
func withTimeout<T>(
    _ operation: @escaping @Sendable () async throws -> T,
    duration: Duration
) async throws -> T {

    @Sendable
    func timeout() async throws -> T {
        try await Task.sleep(for: duration)
        throw ErrorMessage("Timeout exceeded")
    }

    return try await race {
        operation
        timeout
    }

}

@available(
    macOS 13.0,
    iOS 16.0,
    tvOS 16.0,
    watchOS 8.0,
    macCatalyst 15.0, *
)
@inlinable
func withTimeout<T>(
    _ operation: @escaping @Sendable () async -> T,
    duration: Duration
) async throws -> T {

    @Sendable
    func timeout() async throws -> T {
        try await Task.sleep(for: duration)
        throw ErrorMessage("Timeout exceeded")
    }

    return try await race {
        operation
        timeout
    }

}
