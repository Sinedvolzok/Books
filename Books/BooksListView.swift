//
//  BooksListView.swift
//  Books
//
//  Created by Denis Kozlov on 20.04.2024.
//

import SwiftUI
import SwiftData

enum SortOrder: String, CaseIterable, Identifiable {
    case title
    case author
    case status
    var id: Self { self }
}

struct BooksListView: View {
    @State private var isCreatingNewBook = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    @State private var sortFilter = ""
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            BookList(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: "Filer by title or autor")
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
