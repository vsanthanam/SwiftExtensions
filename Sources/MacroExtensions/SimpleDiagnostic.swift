// SwiftExtensions
// SimpleDiagnostic.swift
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

import SwiftDiagnostics

/// A resumable implementation of `DiagnosticMessage`
public struct SimpleDiagnostic: DiagnosticMessage, Equatable, Hashable {

    /// Create a simple diagnostic
    /// - Parameters:
    ///   - message: The message
    ///   - diagnosticID: The diagnostic ID
    ///   - severity: The severity level
    public init(
        message: String,
        diagnosticID: MessageID,
        severity: DiagnosticSeverity
    ) {
        self.message = message
        self.diagnosticID = diagnosticID
        self.severity = severity
    }

    /// Create a simple diagnostic
    /// - Parameters:
    ///   - message: The message
    ///   - domain: The diagnostic message domain
    ///   - id: The diagnostic message ID
    ///   - severity: The severity level
    public init(
        message: String,
        domain: String,
        id: String,
        severity: DiagnosticSeverity
    ) {
        self.init(
            message: message,
            diagnosticID: .init(
                domain: domain,
                id: id
            ),
            severity: severity
        )
    }

    // MARK: - DiagnosticMessage

    @_documentation(visibility: internal)
    public let message: String

    @_documentation(visibility: internal)
    public let diagnosticID: SwiftDiagnostics.MessageID

    @_documentation(visibility: internal)
    public let severity: SwiftDiagnostics.DiagnosticSeverity

}
