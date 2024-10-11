//
//  EditBookView.swift
//  Books
//
//  Created by Denis Kozlov on 17.09.2024.
//

import Foundation
import SwiftUI

struct EditBookView: View {
    
    @Environment(\.dismiss) private var dismiss
    let book: Book
    @State private var title         = ""
    @State private var author        = ""
    @State private var dateAdded     = Date.distantPast
    @State private var dateStarted   = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var synopsis       = ""
    @State private var rating        = 0
    @State private var status        = Status.onShelf
    @State private var firstView     = true
    @State private var recomendedBy  = ""
    var body: some View {
        HStack {
            Text("Status")
            Picker("Pick This", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.description)
                        .tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                switch status {
                case .onShelf:
                    LabeledContent {
                        DatePicker("", selection: $dateAdded,
                                   displayedComponents: .date)
                    } label: {
                        Text("Date Added")
                    }
                case .inProgress:
                     LabeledContent {
                        DatePicker("", selection: $dateStarted,
                                   in: dateAdded...,
                                   displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }                   
                case .completed:
                     LabeledContent {
                        DatePicker("", selection: $dateCompleted,
                                   in: dateStarted...,
                                   displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if !firstView {
                    if newValue == .onShelf {
                        dateStarted   = Date.distantPast
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .completed {
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .onShelf {
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        dateCompleted = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating)
            } label: {
                Text("Rating")
            }
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title")
                    .foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $author)
            } label: {
                Text("Autor")
                    .foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $recomendedBy)
            } label: {
                Text("Recomended by")
                    .foregroundStyle(.secondary)
            }
            Divider()
            Text("Synopsis")
                .foregroundStyle(.secondary)
            TextEditor(text: $synopsis)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(uiColor: .tertiarySystemFill),
                                lineWidth: 1)
                }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    book.title         = title
                    book.author         = author
                    book.dateAdded     = dateAdded
                    book.dateStarted   = dateStarted
                    book.dateCompleted = dateCompleted
                    book.synopsis       = synopsis
                    book.rating        = rating
                    book.status        = status.rawValue
                    book.recomendedBy  = recomendedBy
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            title         = book.title
            author        = book.author
            dateAdded     = book.dateAdded
            dateStarted   = book.dateStarted
            dateCompleted = book.dateCompleted
            synopsis      = book.synopsis
            rating        = book.rating
            recomendedBy  = book.recomendedBy
            status        = Status(rawValue: book.status)!
        }
    }
    
    var changed: Bool {
           title         != book.title
        || author        != book.author
        || dateAdded     != book.dateAdded
        || dateStarted   != book.dateStarted
        || dateCompleted != book.dateCompleted
        || synopsis      != book.synopsis
        || rating        != book.rating
        || recomendedBy  != book.recomendedBy
        || status        != Status(rawValue: book.status)!
    }
}

#Preview {
    let preview = Preview(Book.self)
    return NavigationStack {
        EditBookView(book: Book.mock[4])
            .modelContainer(preview.container)
    }
}
