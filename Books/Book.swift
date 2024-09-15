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
    let title: String
    let autor: String
    let dateAdded: Date
    let dateStarted: Date
    let dateCompleted: Date
    let summary: String
    var rating: Int?
    var status: Status
    
    init(
        title: String,
        autor: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    ) {
        self.title = title
        self.autor = autor
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    var icon: Image {
        switch status {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
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
