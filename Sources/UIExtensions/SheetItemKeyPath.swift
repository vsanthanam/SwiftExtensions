// SwiftExtensions
// SheetItemKeyPath.swift
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

#if canImport(SwiftUI)

    import SwiftUI

    public extension View {

        /// Presents a sheet using the given item as a data source, usin a key path to differentiate bewteen different stable instances of the data source.
        /// for the sheet's content.
        ///
        /// Use this method when you need to present a modal view with content
        /// from a custom data source. The example below shows a custom data source
        /// `InventoryItem` that the `content` closure uses to populate the display
        /// the action sheet shows to the user:
        ///
        /// ```swift
        /// struct ShowPartDetail: View {
        ///
        ///     @State private var sheetDetail: InventoryItem?
        ///
        ///     var body: some View {
        ///         Button("Show Part Details") {
        ///             sheetDetail = InventoryItem(
        ///                 uniqueIdentifier: "0123456789",
        ///                 partNumber: "Z-1234A",
        ///                 quantity: 100,
        ///                 name: "Widget"
        ///             )
        ///         }
        ///         .sheet(item: $sheetDetail,
        ///                id: \.uniqueIdentifier,
        ///                onDismiss: didDismiss) { detail in
        ///             VStack(alignment: .leading, spacing: 20) {
        ///                 Text("Part Number: \(detail.partNumber)")
        ///                 Text("Name: \(detail.name)")
        ///                 Text("Quantity On-Hand: \(detail.quantity)")
        ///             }
        ///             .onTapGesture {
        ///                 sheetDetail = nil
        ///             }
        ///         }
        ///     }
        ///
        ///     func didDismiss() {
        ///         // Handle the dismissing action.
        ///     }
        /// }
        ///
        /// struct InventoryItem {
        ///     var uniqueIdentifier: String
        ///     let partNumber: String
        ///     let quantity: Int
        ///     let name: String
        /// }
        /// ```
        ///
        /// In vertically compact environments, such as iPhone in landscape
        /// orientation, a sheet presentation automatically adapts to appear as a
        /// full-screen cover. Use the `View/presentationCompactAdaptation(_:)` or
        /// `View/presentationCompactAdaptation(horizontal:vertical:)` modifier to
        /// override this behavior.
        ///
        /// - Parameters:
        ///   - item: A binding to an optional source of truth for the sheet.
        ///     When `item` is non-`nil`, the system passes the item's content to
        ///     the modifier's closure. You display this content in a sheet that you
        ///     create that the system displays to the user. If `item` changes,
        ///     the system dismisses the sheet and replaces it with a new one
        ///     using the same process.
        ///   - id: A key path used to differentiate between the identities of different instances of `Item`
        ///   - onDismiss: The closure to execute when dismissing the sheet.
        ///   - content: A closure returning the content of the sheet.
        func sheet<Item, ID, Content>(
            item: Binding<Item?>,
            id: KeyPath<Item, ID>,
            onDismiss: (() -> Void)? = nil,
            @ViewBuilder content: @escaping (Item) -> Content
        ) -> some View where ID: Hashable, Content: View {
            ModifiedContent(
                content: self,
                modifier: SheetItemKeyPathViewModifier(
                    item: item,
                    id: id,
                    onDismiss: onDismiss,
                    content: content
                )
            )
        }

    }

    struct SheetItemKeyPathViewModifier<Item, ID: Hashable, SheetContent: View>: ViewModifier {

        // MARK: - API

        @Binding
        var item: Item?

        let id: KeyPath<Item, ID>

        let onDismiss: (() -> Void)?

        @ViewBuilder
        let content: (Item) -> SheetContent

        // MARK: - ViewModifier

        @MainActor
        @ViewBuilder
        func body(content: Content) -> some View {
            content
                .sheet(item: Binding<WrappedIdentifiable<Item, ID>?>(get: {
                    if let item {
                        WrappedIdentifiable(wrapped: item, keyPath: id)
                    } else {
                        nil
                    }
                }, set: { newValue in
                    item = newValue?.wrapped
                }), content: { item in
                    self.content(item.wrapped)
                })
        }

    }

    struct WrappedIdentifiable<Wrapped, ID>: Identifiable where ID: Hashable {

        // MARK: - Initializers

        init(
            wrapped: Wrapped,
            keyPath: KeyPath<Wrapped, ID>
        ) {
            self.wrapped = wrapped
            self.keyPath = keyPath
        }

        // MARK: - API

        let wrapped: Wrapped

        // MARK: - Identifiable

        var id: ID {
            wrapped[keyPath: keyPath]
        }

        // MARK: - Private

        private let keyPath: KeyPath<Wrapped, ID>

    }

#endif
