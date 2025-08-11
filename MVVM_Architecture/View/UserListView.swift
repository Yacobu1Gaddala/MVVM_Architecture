//
//  UserListView.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import SwiftUI
import SwiftData


struct NotesListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: NotesViewModel
    
    @State private var showAddNote = false
    
    init(context: ModelContext? = nil) {
            if let context = context {
                _viewModel = StateObject(wrappedValue: NotesViewModel(context: context))
            } else {
                _viewModel = StateObject(wrappedValue: NotesViewModel(context: ModelContext(try! ModelContainer(for: Note.self))))
            }
        }
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            
                            Text(note.date, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                    
                }
                .onDelete(perform: viewModel.deleteNote(at:))
            }
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showAddNote = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddNote) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}



#Preview {
    // Create an in-memory container just for preview
    let container = try! ModelContainer(
        for: Note.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    // Insert some sample notes for preview
    let context = container.mainContext
    context.insert(Note(title: "Sample Note 1", content: "This is the first note."))
    context.insert(Note(title: "Sample Note 2", content: "This is the second note."))

    return NotesListView(context: context)
}

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: NotesViewModel
    
    @State private var title = ""
    @State private var content = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Content", text: $content, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
            }
            
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addNote(title: title, content: content)
                        dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}






struct NoteDetailView: View {
    var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.largeTitle)
                .bold()
            
            
            Text(note.date, style: .date)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Divider()
            Text(note.content)
                .font(.body)
            Spacer()
            
        }
        
        .padding()
        .navigationTitle("Note")
    }
}




