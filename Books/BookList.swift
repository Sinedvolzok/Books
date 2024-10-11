//
//  BookList.swift
//  Books
//
//  Created by Denis Kozlov on 02.10.2024.
//

import SwiftUI
import SwiftData

struct BookList: View {
    
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    
    // MARK: init
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\.status), SortDescriptor(\.title)]
        case .title:
            [SortDescriptor(\.title)]
        case .author:
            [SortDescriptor(\.author)]
        }
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterString)
            || book.author.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _books = Query(filter: predicate, sort: sortDescriptors)
    }
    
    // MARK: body
    var body: some View {
        Group {
            if books.isEmpty {
                placeholder
            } else {
                bookList
            }
        }
    }
    
    // MARK: placeholder
    var placeholder: some View {
        ContentUnavailableView {
            Label("No Books", systemImage: "book.fill")
                .padding(10)
        } description: {
            Text("New books will appear here.")
        }
    }
    
    // MARK: bookList
    var bookList: some View {
        List {
            ForEach(books) { book in
                NavigationLink {
                    EditBookView(book: book)
                } label: {
                    BookCell(book: book)
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let book = books[index]
                    context.delete(book)
                }
            }
        }
        .listStyle(.plain)
        .padding()
    }
}

struct BookCell: View {
    let book: Book
    var body: some View {
        HStack(spacing: 12) {
            book.icon
            VStack(alignment: .leading){
                Text(book.title)
                    .font(.title2)
                Text(book.author)
                    .foregroundStyle(.secondary)
                let rating = book.rating
                if rating > 0 {
                    HStack {
                        ForEach(0..<5) { index in
                            Image(systemName:
                                    index < rating ? "star.fill" : "star")
                            .foregroundColor(
                                index < rating ? .yellow : .secondary
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExempes(Book.mock)
    return NavigationStack { BookList(sortOrder: .title, filterString: "") }
        .modelContainer(preview.container)
}
