//
//  BooksListView.swift
//  Books
//
//  Created by Denis Kozlov on 20.04.2024.
//

import SwiftUI
import SwiftData

struct BooksListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var isCreatingNewBook = false
    var body: some View {
        NavigationStack {
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
            .navigationTitle("My Books")
            .toolbar {
                Button {
                    isCreatingNewBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                    
                }
            }
            .sheet(isPresented: $isCreatingNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExempes(Book.mock)
    return BooksListView()
        .modelContainer(preview.container)
}
