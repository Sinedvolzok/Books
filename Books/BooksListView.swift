//
//  BooksListView.swift
//  Books
//
//  Created by Denis Kozlov on 20.04.2024.
//

import SwiftUI
import SwiftData

struct BooksListView: View {
    @Query(sort: \Book.title) private var books: [Book]
    @State private var isCreatingNewBook = false
    var body: some View {
        NavigationStack {
            VStack (spacing: 12) {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            Text(book.title)
                        } label: {
                            HStack(spacing: 12) {
                                book.icon
                                VStack(alignment: .leading){
                                    Text(book.title)
                                        .font(.title2)
                                    Text(book.autor)
                                        .foregroundStyle(.secondary)
                                    if let rating = book.rating {
                                        HStack {
                                            ForEach(0..<rating, id: \.self) {_ in 
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
                }
                .listStyle(.plain)
            }
            .padding()
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
    BooksListView()
        .modelContainer(for: Book.self, inMemory: true)
}
