//
//  ViewController.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import UIKit

class StartVC: VC {
    
    static let CreateNoteView: CreateNoteVC = CreateNoteVC()
    
    let table = Table()
    
    static var OnEditMode = false
    
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
            StartVC.CreateNoteView.previousVC = self
            StartVC.CreateNoteView.modalPresentationStyle = .overFullScreen
            self.present(StartVC.CreateNoteView, animated: true)
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
        
        UserDefaults.standard.synchronize()
        //LoadNotes()
        
        
        /*let bttnWithLabel = Button(Label("HelloWorld".Translated)) {
            debugPrint("Pressed")
        }
        bttnWithLabel.backgroundColor = .blue
        bttnWithLabel.label?.backgroundColor = .lightGray
        
        otherView.addSubview(bttnWithLabel)
        bttnWithLabel.EnableConstraints()
            .AlingLeftTo(otherView)
            .AlingTopTo(otherView)
         
        
        UserDefaults.standard.set("Cosas", forKey: "Cosas_Key")
        debugPrint(UserDefaults.standard.value(forKey: "Cosas_Key"))
        
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "AppOpenTimes") + 1, forKey: "AppOpenTimes")
        UserDefaults.standard.synchronize()
        debugPrint(UserDefaults.standard.integer(forKey: "AppOpenTimes"))
        
        var note = Note(title: "Test title", description: "TestDescription", color: NamedUIColor(name: "PrimaryColor"), type: .Work)
        UserDefaults.standard.Save(data: note, key: "Note1")
        */
    }
    
    
    func AddNote(noteTitle: String, noteContent: String) {
        self.table.AddCell(noteTitle: noteTitle, noteContent: noteContent)
    }
    
    
    /*func LoadNotes() {
        let notesAmount = UserDefaults.standard.integer(forKey: "NotesAmount")
        for currNoteId in 0 ... notesAmount {
            let note: Note = UserDefaults.standard.get<Note>(Note.Type, key: "NoteId_" + String(currNoteId))
            table.AddCell(noteTitle: note.title, noteContent: note.description)
        }
    }*/
    
    func SaveNewNote(note: Note) {
        UserDefaults.standard.set(table.notes.count, forKey: "NotesAmount")
        UserDefaults.standard.Save(data: note, key: "NoteId_" + String(table.notes.count - 1))
    }
    
    func SaveNotesIdxChange(note1: Note, note2: Note, note1Id: Int, note2Id: Int) {
        UserDefaults.standard.Save(data: note1, key: "NoteId_" + String(note2Id))
        UserDefaults.standard.Save(data: note2, key: "NoteId_" + String(note1Id))
    }

}

class Table: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var notes: [Note] = [
        Note(title: "Note1", description: "djksf", color: NamedUIColor(name: "Purple"), type: .Work),
        Note(title: "Note2", description: "djkfdbvsf djkfdbvsf djkfdbvsf djkfdbvsf", color: NamedUIColor(name: "White"), type: .Shop)
    ]
    let table = UITableView()
    
    init() {
        super.init(frame: .zero, style: .grouped)
        
        self.addSubview(table)
        table.PinTo(other: self)
        
        table.delegate = self
        table.dataSource = self
        
        table.register(NoteCell.self, forCellReuseIdentifier: NoteCell.Id)
        
        table.reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("Notes Count: " + String(notes.count))
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: NoteCell.Id) as? NoteCell else {
            return UITableViewCell()
        }
        
        cell.cellTitle.text = self.notes[indexPath.row].title
        cell.cellDescription.text = self.notes[indexPath.row].description
        cell.backgroundColor = NamedUIColor.BgPrincipal.Color
        cell.cellSeparator.backgroundColor = NamedUIColor.Separator.Color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NoteCell.CellSize
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Note " + String(indexPath.row) + " clicked")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        if(editingStyle == .delete) {
            notes.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    
    func EnableEditMode(_ enable: Bool) {
        table.setEditing(enable, animated: true)
        StartVC.OnEditMode = enable
    }
    
    
    func AddCell(noteTitle: String, noteContent: String) {
        let newNote = Note(title: noteTitle, description: noteContent, color: NamedUIColor(name: "White"), type: .Shop)
        notes.append(newNote)
        debugPrint(notes)
        self.table.reloadData()
    }
}


class NoteCell: UITableViewCell {
    
    lazy var cellTitle: Label = {
        let label = Label("Title", style: .title1)
        self.addSubview(label)
        label
            .SetHeight(.padding4)
            .AlingLeftTo(self, padding: .padding4)
            .AlingTopTo(self, padding: .paddingLow)
        
        return label
    }()
    
    lazy var cellSeparator: UIView = {
        let separator = UIView()
        self.addSubview(separator)
        separator.EnableConstraints()
            .SetHeight(.paddingLow)
            .AlingTopTo(cellTitle, padding: .padding4)
            .AlingRightTo(self, padding: .padding4)
            .AlingLeftTo(self, padding: .padding4)
        //separator.backgroundColor = NamedUIColor.Separator.Color
        //separator.backgroundColor = .black
        
        return separator
    }()
    
    lazy var cellDescription: TextView = {
        let description = TextView("Description")
        description.textAlignment = .left
        description.font = UIFont.systemFont(ofSize: 15.0)
        self.addSubview(description)
        description.EnableConstraints()
            .AlingTopTo(cellSeparator, padding: .padding)
            .AlingBotTo(self, padding: .padding)
            .AlingRightTo(self, padding: .padding4)
            .AlingLeftTo(self, padding: .padding4)
        
        return description
    }()
    
    
    static var Id: String {
        return "NoteCell"
    }
    static let CellSize:CGFloat = 120
    
}
