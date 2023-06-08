//
//  UserDefaults+Storage.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation

extension UserDefaults {
    
    @discardableResult func Save(data: Encodable, key: String) -> Bool
    {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            self.set(encoded, forKey: key)
            return true
        }
        
        return false
    }
    
    func get<T:Decodable>(_ t: T.Type, key: String) -> T?
    {
        if let data = self.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let dataObj = try? decoder.decode(T.self, from: data) {
                return dataObj
            }
        }
        return nil
    }
    
    //MARK: Loading
    static func LoadSavedNotes() {
        guard let startVC = StartVC.StartVCRef else { return }
        let notesAmount = UserDefaults.standard.integer(forKey: "NotesAmount")
        for currNoteId in 0 ... notesAmount {
            guard let note = UserDefaults.standard.get(Note.self, key: "NoteId_" + String(currNoteId)) else { return }
            startVC.table.AddCell(noteTitle: note.title, noteContent: note.description)
        }
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Saving
    static func SaveNewNote(note: Note) {
        guard let startVC = StartVC.StartVCRef else { return }
        UserDefaults.standard.set(startVC.table.notes.count, forKey: "NotesAmount")
        UserDefaults.standard.Save(data: note, key: "NoteId_" + String(startVC.table.notes.count - 1))
        UserDefaults.standard.synchronize()
    }
    static func SaveExistingNote(note: Note, noteIdx: Int) {
        UserDefaults.standard.Save(data: note, key: "NoteId_" + String(noteIdx))
        UserDefaults.standard.synchronize()
    }
    
    static func SaveNotesIdxChange(note1: Note, note2: Note, note1NewId: Int, note2NewId: Int) {
        UserDefaults.standard.Save(data: note1, key: "NoteId_" + String(note1NewId))
        UserDefaults.standard.Save(data: note2, key: "NoteId_" + String(note2NewId))
        UserDefaults.standard.synchronize()
    }
    
    static func RefresSavedNotesIndexes(notes: [Note], startDeletionNoteIdx: Int = 0) {
        if(startDeletionNoteIdx < notes.count) {
            for currNoteId in startDeletionNoteIdx ... notes.count - 1 {
                UserDefaults.standard.Save(data: notes[currNoteId], key: "NoteId_" + String(currNoteId))
            }
        }
        UserDefaults.standard.removeObject(forKey: "NoteId_" + String(notes.count))
        UserDefaults.standard.set(notes.count, forKey: "NotesAmount")
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Deleting
    static func DeleteSavedNotesData(){
        let notesAmount = UserDefaults.standard.integer(forKey: "NotesAmount")
        for currNoteId in 0 ... notesAmount {
            UserDefaults.standard.removeObject(forKey: "NoteId_" + String(currNoteId))
        }
        UserDefaults.standard.set(0, forKey: "NotesAmount")
        UserDefaults.standard.synchronize()
    }
    
    
}
