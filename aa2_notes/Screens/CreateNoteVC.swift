//
//  CreateNoteVC.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 1/6/23.
//

import Foundation
import UIKit

class CreateNoteVC: VC {
    
    enum Mode {
        case ViewMode
        case EditMode
        case CreateMode
    }
    
    let buttonsWidth: CGFloat = 90
    let titleWidth: CGFloat = 120
    
    let editableTitle = TextView("Title")
    let editableText = TextView("Click to edit")
    var noteIdx = 0
    
    var ViewMode = Mode.ViewMode
    
    //var previousVC = StartVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        editableTitle.text = "NotesTitleEditable".Translated
        editableTitle.textAlignment = .center
        editableTitle.backgroundColor = .clear
        editableTitle.font = UIFont.boldSystemFont(ofSize: 17)
        editableTitle.isEditable = true
        editableTitle.isSelectable = true
        editableTitle.isUserInteractionEnabled = true
        titleView.addSubview(editableTitle)
        editableTitle.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .CenterXTo(titleView.centerXAnchor)
            .SetWidth(titleWidth)
        
        
        var leftBtn = Button()
        if(ViewMode == .EditMode) {
            leftBtn = Button(Label("SaveBttn".Translated, style: .caption1)) { button in
                self.SaveEditedNote()
                self.dismiss(animated: true)
            }
        }
        else if(ViewMode == .CreateMode) {
            leftBtn = Button(Label("SaveBttn".Translated, style: .caption1)) { button in
                self.SaveNewNote()
                self.dismiss(animated: true)
            }
        }
        leftBtn.backgroundColor = .green
        titleView.addSubview(leftBtn)
        leftBtn.cornerRadius = 10
        leftBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingLeftTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(buttonsWidth)
        
        
        let rightBtn = Button(Label("CancelBttn".Translated, style: .caption1)) { button in
            self.dismiss(animated: true)
        }
        rightBtn.backgroundColor = .red
        rightBtn.cornerRadius = 10
        titleView.addSubview(rightBtn)
        rightBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingRightTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(buttonsWidth)
        
        
        ///
        
        // Notes View
        let createNoteView = UIView()
        createNoteView.backgroundColor = .white
        self.view.addSubview(createNoteView)
        //notesView.PinTo(other: self.view)
        createNoteView.EnableConstraints()
            .AlingRightTo(self.view)
            .AlingLeftTo(self.view)
            .AlignTopToBot(titleView)
            .AlingBotTo(self.view, safeArea: false)
        
        
        editableText.text = "ClickToEdit".Translated
        editableText.textAlignment = .left
        editableText.font = UIFont.systemFont(ofSize: 15.0)
        editableText.isEditable = true
        editableText.isSelectable = true
        editableText.isUserInteractionEnabled = true
        createNoteView.addSubview(editableText)
        editableText.PinTo(other: createNoteView, padding: .padding2)
        //editableText.AlingTopTo(titleView, 100)
        
        
    }
    
    func SaveEditedNote() {
        guard let startVC = StartVC.StartVCRef else { return }
        let editedNote = startVC.ModifyNote(noteTitle: editableTitle.text, noteContent: editableText.text, noteIdx: noteIdx)
        startVC.SaveExistingNote(note: editedNote, noteIdx: noteIdx)
    }
    func SaveNewNote() {
        guard let startVC = StartVC.StartVCRef else { return }
        startVC.AddNote(noteTitle: editableTitle.text, noteContent: editableText.text)
        let noteIdx: Int = startVC.table.notes.count - 1
        startVC.SaveNewNote(note: startVC.table.notes[noteIdx])
    }
}
