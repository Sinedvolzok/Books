//
//  PreviewContainer.swift
//  Books
//
//  Created by Denis Kozlov on 29.09.2024.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(
                for: schema,
                configurations: config
            )
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
    
    func addExempes(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { exemple in
                container.mainContext.insert(exemple)
            }
            
        }
    }
}
