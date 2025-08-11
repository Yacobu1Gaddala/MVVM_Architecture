//
//  MVVM_ArchitectureApp.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import SwiftUI
import SwiftData

@main
struct MVVM_ArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
           NotesListView()
        }
        .modelContainer(for: Note.self)
    }
    
    
    private var modelContext: ModelContext {
        let container = try! ModelContainer(for: Note.self)
        return container.mainContext
    }
}
