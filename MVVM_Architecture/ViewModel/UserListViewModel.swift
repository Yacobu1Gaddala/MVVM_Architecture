//
//  UserListViewModel.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import SwiftUI
import SwiftData


@MainActor
class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchNotes()
    }
    
    
    func fetchNotes() {
        do {
            let descriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            notes = try context.fetch(descriptor)
        }catch {
            print("Failed to fetch notes: \(error)")
        }
    }
    
    
    func addNote(title: String, content: String) {
        let note = Note(title: title, content: content)
        context.insert(note)
        saveContext()
        fetchNotes()
        
    }
    
    func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            context.delete(notes[index])
        }
        saveContext()
        fetchNotes()
    }
    
    
    private func saveContext() {
        do {
            try context.save()
        }catch {
            print("Failed to save context:\(error)")
        }
    }
}

