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
    
    let titleView = UIView()
    
    let editableTitle = TextView("Title")
    let editableText = TextView("Click to edit")
    var noteIdx: IndexPath = IndexPath()
    
    var ViewMode: Mode = .ViewMode
    var editBtn = Button()
    var goBackBtn = Button()
    var saveNewNoteBtn = Button()
    var saveChangesBtn = Button()
    var cancelBtn = Button()
    var deleteNoteBtn = Button()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title View
        titleView.backgroundColor = .purple
        self.view.addSubview(titleView)
        titleView.EnableConstraints()
            .AlingTopTo(self.view, padding: 0.0, safeArea: false)
            .AlingLeftTo(self.view)
            .AlingRightTo(self.view)
        titleView.heightAnchor.constraint(equalToConstant: .titleViewHeight).isActive = true
        
        editableTitle.text = "NotesTitleEditable".Translated
        editableTitle.textAlignment = .center
        editableTitle.backgroundColor = .clear
        editableTitle.font = UIFont.boldSystemFont(ofSize: 17)
        titleView.addSubview(editableTitle)
        editableTitle.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .CenterXTo(titleView.centerXAnchor)
            .SetWidth(.titleWidth)
        
        CreateEditBtn()
        CreateGoBackBtn()
        CreateSaveNewNoteBtn()
        CreateSaveChangesBtn()
        CreateCancelBtn()
        
        ///
        
        
        // Notes View
        let createNoteView = UIView()
        createNoteView.backgroundColor = NamedUIColor.BgPrincipal.Color
        self.view.addSubview(createNoteView)
        createNoteView.EnableConstraints()
            .AlingRightTo(self.view)
            .AlingLeftTo(self.view)
            .AlignTopToBot(titleView)
            .AlingBotTo(self.view, safeArea: false)
        
        
        editableText.text = "ClickToEdit".Translated
        editableText.textAlignment = .left
        editableText.font = UIFont.systemFont(ofSize: 15.0)
        createNoteView.addSubview(editableText)
        editableText.PinTo(other: createNoteView, padding: .padding2)
        
        deleteNoteBtn = Button(Label("-")) { button in
            debugPrint("+ Pressed")
            guard let startVC = StartVC.StartVCRef else { return }
            startVC.table.DeleteCell(indexPath: self.noteIdx)
            self.dismiss(animated: true)
        }
        createNoteView.addSubview(deleteNoteBtn)
        deleteNoteBtn.backgroundColor = .systemRed
        deleteNoteBtn.label?.font = UIFont.boldSystemFont(ofSize: 20)
        deleteNoteBtn.cornerRadius = .cornerRadius
        deleteNoteBtn
            .SetWidth(.floatingBtnSize)
            .SetHeight(.floatingBtnSize)
            .AlingRightTo(createNoteView, padding: .padding4)
            .AlingBotTo(createNoteView, padding: .padding4)
        
        ///
        
        
        LoadViewMode(loadedViewMode: ViewMode)
    }
    
    
    func CreateEditBtn() {
        editBtn = Button(Label("EditBttn".Translated, style: .caption1)) { button in
            self.LoadEditMode()
        }
        editBtn.backgroundColor = .systemYellow
        editBtn.cornerRadius = .cornerRadius
        
        titleView.addSubview(editBtn)
        editBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingLeftTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(.buttonsWidth)
    }
    
    func CreateGoBackBtn() {
        goBackBtn = Button(Label("GoBackBttn".Translated, style: .caption1)) { button in
            self.dismiss(animated: true)
        }
        goBackBtn.backgroundColor = .systemYellow
        goBackBtn.cornerRadius = .cornerRadius
        
        titleView.addSubview(goBackBtn)
        goBackBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingRightTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(.buttonsWidth)
    }
    
    func CreateSaveNewNoteBtn() {
        saveNewNoteBtn = Button(Label("SaveBttn".Translated, style: .caption1)) { button in
            self.SaveNewNote()
            self.dismiss(animated: true)
        }
        saveNewNoteBtn.backgroundColor = .green
        saveNewNoteBtn.cornerRadius = .cornerRadius
        
        titleView.addSubview(saveNewNoteBtn)
        saveNewNoteBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingLeftTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(.buttonsWidth)
    }
    
    func CreateSaveChangesBtn() {
        saveChangesBtn = Button(Label("SaveBttn".Translated, style: .caption1)) { button in
            self.SaveEditedNote()
            self.dismiss(animated: true)
        }
        saveChangesBtn.backgroundColor = .green
        saveChangesBtn.cornerRadius = .cornerRadius
        
        titleView.addSubview(saveChangesBtn)
        saveChangesBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingLeftTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(.buttonsWidth)
    }
    
    func CreateCancelBtn() {
        cancelBtn = Button(Label("CancelBttn".Translated, style: .caption1)) { button in
            self.dismiss(animated: true)
        }
        cancelBtn.backgroundColor = .red
        cancelBtn.cornerRadius = .cornerRadius
        
        titleView.addSubview(cancelBtn)
        cancelBtn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingRightTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(.buttonsWidth)
    }
    
    
    func LoadViewMode(loadedViewMode: Mode) {
        switch(loadedViewMode){
        case .ViewMode:
            LoadViewMode()
            
        case .EditMode:
            LoadEditMode()
            
        case .CreateMode:
            LoadCreateMode()
            
        }
        
    }
    
    func LoadViewMode() {
        SetTextViewEditable(editableTitle, editable: false)
        SetTextViewEditable(editableText, editable: false)
        editBtn.isHidden = false
        goBackBtn.isHidden = false
        saveNewNoteBtn.isHidden = true
        saveChangesBtn.isHidden = true
        cancelBtn.isHidden = true
        deleteNoteBtn.isHidden = true
    }
    
    func LoadEditMode() {
        SetTextViewEditable(editableTitle, editable: true)
        SetTextViewEditable(editableText, editable: true)
        editBtn.isHidden = true
        goBackBtn.isHidden = true
        saveNewNoteBtn.isHidden = true
        saveChangesBtn.isHidden = false
        cancelBtn.isHidden = false
        deleteNoteBtn.isHidden = false
    }
    
    func LoadCreateMode() {
        SetTextViewEditable(editableTitle, editable: true)
        SetTextViewEditable(editableText, editable: true)
        editBtn.isHidden = true
        goBackBtn.isHidden = true
        saveNewNoteBtn.isHidden = false
        saveChangesBtn.isHidden = true
        cancelBtn.isHidden = false
        deleteNoteBtn.isHidden = true
    }
    
    func SaveEditedNote() {
        guard let startVC = StartVC.StartVCRef else { return }
        let editedNote = startVC.ModifyNote(noteTitle: editableTitle.text, noteContent: editableText.text, noteIdx: noteIdx.row)
        UserDefaults.SaveExistingNote(note: editedNote, noteIdx: self.noteIdx.row)
    }
    func SaveNewNote() {
        guard let startVC = StartVC.StartVCRef else { return }
        startVC.AddNote(noteTitle: editableTitle.text, noteContent: editableText.text)
        let newNoteIdx: Int = startVC.table.notes.count - 1
        UserDefaults.SaveNewNote(note: startVC.table.notes[newNoteIdx])
    }
    
    
    func SetTextViewEditable(_ textView: TextView, editable: Bool) {
        textView.isEditable = editable
        textView.isSelectable = editable
        textView.isUserInteractionEnabled = editable
    }
    
}
