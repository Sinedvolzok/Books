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
        List {
            let sortedQuotes = book.quotes?.sorted(using:
                KeyPathComparator(\Quote.creationDate)) ?? []
            ForEach(sortedQuotes) { quote in
                VStack(alignment: .leading) {
                    Text(
                        quote.creationDate,
                        format: .dateTime.month().day().year()
                    )
                    Text(quote.text)
                    HStack {
                        Spacer()
                        if let page = quote.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                    selectedQuote = quote
                    text = quote.text
                    page = quote.page ?? ""
                }
            }
            .onDelete { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            if let quote = book.quotes?[index] {
                                modelContext.delete(quote)
                            }
                        }
                    }
                }
        }
        .listStyle(.plain)
        .navigationTitle("Qoutes")
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.mock
    preview.addExempes(books)
    return NavigationStack {
        QuoteListIView(book: books[2])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
