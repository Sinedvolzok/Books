//
//  Book.swift
//  Books
//
//  Created by Denis Kozlov on 10.09.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    @Attribute(originalName: "summary")
    var synopsis: String
    var rating: Int = 0
    var status: Status.RawValue
    var recomendedBy: String = ""
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        synopsis: String = "",
        rating: Int = 0,
        status: Status = .onShelf,
        recomendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recomendedBy = recomendedBy
    }
    
    var icon: Image {
        switch Status(rawValue: status) {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        case .none:
            Image(systemName: "book")
        }
        
    }
    
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var description: String {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "inProgress"
        case .completed:
            "completed"
        }
    }
}
