//
//  GenresView.swift
//  Books
//
//  Created by Denis Kozlov on 23.10.2024.
//

import SwiftData
import SwiftUI

struct GenresView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var book: Book
    @Query(sort: \Genre.name) var genres: [Genre]
    @State private var isNew = false
    
    var body: some View {
        NavigationStack{
            Group {
                if genres.isEmpty {
                    PlaceholderView(new: $isNew)
                } else {
                    List {
                        ForEach(genres) { genre in
                            HStack {
                                if let bookGenres = book.genres {
                                    Button {
                                        addRemove(genre)
                                    } label: {
                                        Image(
                                            systemName:
                                                bookGenres.contains(genre)
                                                ? "circle.fill":"circle"
                                        )
                                        .foregroundStyle(genre.hexColor
                                        )
                                    }
                                    
                                    Text(genre.name)
                                }
                            }
                        }
                        LabeledContent {
                            Button {
                                isNew.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Add Genre")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(book.title)
            .sheet(isPresented: $isNew) {
                NewGenreView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addRemove(_ genre: Genre) {
        
        if let bookGenres = book.genres {
            if bookGenres.isEmpty {
                book.genres?.append(genre)
            } else {
                if bookGenres.contains(genre),
                   let index = bookGenres.firstIndex(of: genre) {
                    book.genres?.remove(at: index)
                } else {
                    book.genres?.append(genre)
                }
            }
        }
    }
}
struct PlaceholderView: View {
    @Binding var new: Bool
    var body: some View {
        ContentUnavailableView {
            Image(systemName: "bookmark.fill")
                .font(.largeTitle)
        } description: {
            Text("You need to create some genres first.")
        } actions: {
            Button("Add Genre") {
                new.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.mock
    let genres = Genre.mock
    preview.addExempes(books)
    preview.addExempes(genres)
    books[1].genres?.append(genres[0])
    return GenresView(book: books[1])
        .modelContainer(preview.container)
}
