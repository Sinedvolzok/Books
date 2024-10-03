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
    var body: some View {
         Group {
                if books.isEmpty {
                    ContentUnavailableView {
                        Label("No Books", systemImage: "book.fill")
                            .padding(10)
                    } description: {
                        Text("New books will appear here.")
                    }

                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                EditBookView(book: book)
                            } label: {
                                HStack(spacing: 12) {
                                    book.icon
                                    VStack(alignment: .leading){
                                        Text(book.title)
                                            .font(.title2)
                                        Text(book.author)
                                            .foregroundStyle(.secondary)
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self) {_ in
                                                    Image(systemName: "fill.star")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
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
    }
}

#Preview {
    
    let preview = Preview(Book.self)
    preview.addExempes(Book.mock)
    return NavigationStack { BookList(sortOrder: .title, filterString: "") }
        .modelContainer(preview.container)
}
