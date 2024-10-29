//
//  Quote.swift
//  Books
//
//  Created by Denis Kozlov on 14.10.2024.
//

import Foundation
import SwiftData

@Model
final class Quote {
    var creationDate: Date = Date.now
    var text: String
    var page: String?
    weak var book: Book?

    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
}
