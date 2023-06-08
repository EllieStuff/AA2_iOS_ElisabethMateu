//
//  ViewController.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import UIKit

class StartVC: VC {
    
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
        titleView.heightAnchor.constraint(equalToConstant: .titleViewHeight).isActive = true
        
        let title = Label("NotesTitle".Translated)
        title.font = UIFont.boldSystemFont(ofSize: 20)
        titleView.addSubview(title)
        title.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding2)
            .CenterXTo(titleView.centerXAnchor)
        
        let editBttn = Button(Label("EditBttn".Translated, style: .caption1)) { button in
            debugPrint("Edit Pressed")
            self.table.EnableEditMode(!StartVC.OnEditMode)
        }
        editBttn.backgroundColor = .systemYellow
        editBttn.cornerRadius = .cornerRadius
        titleView.addSubview(editBttn)
        editBttn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingRightTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(.buttonsWidth)
        
        ///
        
        
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
            self.table.EnableEditMode(false)
            self.LoadCreateNoteVC(.CreateMode)
        }
        notesView.addSubview(addNoteBttn)
        addNoteBttn.backgroundColor = .green
        addNoteBttn.label?.font = UIFont.boldSystemFont(ofSize: 20)
        addNoteBttn.cornerRadius = .cornerRadius
        addNoteBttn
            .SetWidth(.floatingBtnSize)
            .SetHeight(.floatingBtnSize)
            .AlingRightTo(notesView, padding: .padding4)
            .AlingBotTo(notesView, padding: .padding4)
        
        ///
        
        
        UserDefaults.LoadSavedNotes()
        
    }
    
    
    func ModifyNote(noteTitle: String, noteContent: String, noteIdx: Int) -> Note {
        table.ModifyCell(noteTitle: noteTitle, noteContent: noteContent, noteIdx: noteIdx)
        return table.notes[noteIdx]
    }
    func AddNote(noteTitle: String, noteContent: String) {
        self.table.AddCell(noteTitle: noteTitle, noteContent: noteContent)
    }
    
    
    @discardableResult func LoadCreateNoteVC(_ viewMode: CreateNoteVC.Mode) -> CreateNoteVC {
        let createNoteVC = CreateNoteVC()
        createNoteVC.ViewMode = viewMode
        createNoteVC.modalPresentationStyle = .overFullScreen
        self.present(createNoteVC, animated: true)
        return createNoteVC
    }
    
}


