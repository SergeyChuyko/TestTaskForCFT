//
//  NoteViewModel.swift
//  TestTaskIOS
//
//  Created by Sergo on 27.01.2024.
//

import Foundation

class NotesViewModel {
    var notes: [Note] = []

    func getNotes() -> [Note] {
        return notes
    }

    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
    }
}
