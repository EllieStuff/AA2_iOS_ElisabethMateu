//
//  ViewController.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import UIKit

class StartVC: VC {
    
    //static let CreateNoteView: CreateNoteVC = CreateNoteVC()
    static var StartVCRef: StartVC?
    
    let table = Table()
    
    static var OnEditMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartVC.StartVCRef = self
        
        // Title View
        let titleView = UIView()
        titleView.backgroundColor = .purple
        self.view.addSubview(titleView)
        titleView.EnableConstraints()
            .AlingTopTo(self.view, padding: 0.0, safeArea: false)
            .AlingLeftTo(self.view)
            .AlingRightTo(self.view)
            //.SetHeight(120)
        titleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let title = Label("NotesTitle".Translated)
        title.font = UIFont.boldSystemFont(ofSize: 20)
        titleView.addSubview(title)
        title.EnableConstraints()
            .AlingBotTo(titleView, padding: 20)
            .CenterXTo(titleView.centerXAnchor)
        
        let editBttn = Button(Label("EditBttn".Translated, style: .caption1)) { button in
            debugPrint("Edit Pressed")
            self.table.EnableEditMode(!StartVC.OnEditMode)
        }
        titleView.addSubview(editBttn)
        editBttn.EnableConstraints()
            .AlingBotTo(titleView, padding: 20.0)
            .AlingRightTo(titleView, padding: 20.0)
        
        ////
        
        
        // Notes View
        let notesView = UIView()
        notesView.backgroundColor = .white
        self.view.addSubview(notesView)
        notesView.EnableConstraints()
            .AlingRightTo(self.view)
            .AlingLeftTo(self.view)
            .AlignTopToBot(titleView)
            .AlingBotTo(self.view, safeArea: false)
        
        
        notesView.addSubview(table)
        table.PinTo(other: notesView)
        
        
        let addNoteBttn = Button(Label("+")) { button in
            debugPrint("+ Pressed")
            self.LoadCreateNoteVC(.CreateMode)
        }
        notesView.addSubview(addNoteBttn)
        addNoteBttn.backgroundColor = .green
        addNoteBttn.label?.font = UIFont.boldSystemFont(ofSize: 20)
        addNoteBttn.cornerRadius = 4
        addNoteBttn
            .SetWidth(40)
            .SetHeight(40)
            .AlingRightTo(notesView, padding: .padding4)
            .AlingBotTo(notesView, padding: .padding4)
        
        
        //
        
        
        LoadNotes()
        
    }
    
    
    func ModifyNote(noteTitle: String, noteContent: String, noteIdx: Int) -> Note {
        table.ModifyCell(noteTitle: noteTitle, noteContent: noteContent, noteIdx: noteIdx)
        return table.notes[noteIdx]
    }
    func AddNote(noteTitle: String, noteContent: String) {
        self.table.AddCell(noteTitle: noteTitle, noteContent: noteContent)
    }
    
    
    func LoadNotes() {
        let notesAmount = UserDefaults.standard.integer(forKey: "NotesAmount")
        for currNoteId in 0 ... notesAmount {
            guard let note = UserDefaults.standard.get(Note.self, key: "NoteId_" + String(currNoteId)) else { return }
            table.AddCell(noteTitle: note.title, noteContent: note.description)
        }
        UserDefaults.standard.synchronize()
    }
    
    func SaveNewNote(note: Note) {
        UserDefaults.standard.set(table.notes.count, forKey: "NotesAmount")
        UserDefaults.standard.Save(data: note, key: "NoteId_" + String(table.notes.count - 1))
        UserDefaults.standard.synchronize()
    }
    func SaveExistingNote(note: Note, noteIdx: Int) {
        UserDefaults.standard.Save(data: note, key: "NoteId_" + String(noteIdx))
        UserDefaults.standard.synchronize()
    }
    
    func SaveNotesIdxChange(note1: Note, note2: Note, note1Id: Int, note2Id: Int) {
        UserDefaults.standard.Save(data: note1, key: "NoteId_" + String(note2Id))
        UserDefaults.standard.Save(data: note2, key: "NoteId_" + String(note1Id))
        UserDefaults.standard.synchronize()
    }
    
    func DeleteSavedData(){
        let notesAmount = UserDefaults.standard.integer(forKey: "NotesAmount")
        for currNoteId in 0 ... notesAmount {
            UserDefaults.standard.removeObject(forKey: "NoteId_" + String(currNoteId))
        }
        UserDefaults.standard.set(0, forKey: "NotesAmount")
    }
    
    
    @discardableResult func LoadCreateNoteVC(_ viewMode: CreateNoteVC.Mode) -> CreateNoteVC {
        let createNoteVC = CreateNoteVC()
        createNoteVC.ViewMode = viewMode
        createNoteVC.modalPresentationStyle = .overFullScreen
        self.present(createNoteVC, animated: true)
        return createNoteVC
    }

}


