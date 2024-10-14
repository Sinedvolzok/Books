//
//  QuoteListIView.swift
//  Books
//
//  Created by Denis Kozlov on 14.10.2024.
//

import SwiftUI

struct QuoteListIView: View {
    @Environment(\.modelContext) private var modelContext
    let book: Book
    @State private var text = ""
    @State private var page = ""
    @State private var selectedQuote: Quote?
    var isEditing: Bool {
        selectedQuote != nil
    }
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("page #", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        text = ""
                        selectedQuote = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.page = page.isEmpty ? nil : page
                        selectedQuote?.text = text
                        page = ""
                        text = ""
                        selectedQuote = nil
                    } else {
                        let quote = page.isEmpty ?
                        Quote(text: text)
                        :
                        Quote(text: text,page: page)
                        book.quotes?.append(quote)
                        page = ""
                        text = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .border(.secondary)
                .frame(height: 100)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.mock
    preview.addExempes(books)
    return NavigationStack {
        QuoteListIView(book: books[2])
            .modelContainer(preview.container)
    }
}
