//
//  CreateNoteVC.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 1/6/23.
//

import Foundation
import UIKit

class CreateNoteVC: VC {
    
    let buttonsWidth: CGFloat = 100
    
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
        
        let title = Label("NotesTitle".Translated)
        title.font = UIFont.boldSystemFont(ofSize: 20)
        titleView.addSubview(title)
        title.EnableConstraints()
            .AlingBotTo(titleView, padding: 20)
            .CenterXTo(titleView.centerXAnchor)
        
        let saveBttn = Button(Label("SaveBttn".Translated, style: .caption1)) { button in
            
        }
        saveBttn.backgroundColor = .green
        titleView.addSubview(saveBttn)
        saveBttn.cornerRadius = 10
        saveBttn.EnableConstraints()
            .AlingBotTo(titleView, padding: .padding)
            .AlingLeftTo(titleView, padding: .padding)
            .AlingTopTo(titleView, padding: .padding)
            .SetWidth(buttonsWidth)
        
        let cancelBttn = Button(Label("CancelBttn".Translated, style: .caption1)) { button in
            self.dismiss(animated: true)
        }
        cancelBttn.backgroundColor = .red
        cancelBttn.cornerRadius = 10
        titleView.addSubview(cancelBttn)
        cancelBttn.EnableConstraints()
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
        
        let editableText = TextView("...")
        editableText.textAlignment = .left
        editableText.font = UIFont.systemFont(ofSize: 15.0)
        createNoteView.addSubview(editableText)
        editableText.PinTo(other: createNoteView)
        //editableText.AlingTopTo(titleView, 100)
        
        
    }
}
