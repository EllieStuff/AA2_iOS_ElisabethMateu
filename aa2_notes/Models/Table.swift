//
//  Table.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 7/6/23.
//

import Foundation
import UIKit

class Table: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var notes: [Note] = []
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedNote = notes[sourceIndexPath.item]
        notes.remove(at: sourceIndexPath.item)
        notes.insert(movedNote, at: destinationIndexPath.item)
        UserDefaults.SaveNotesIdxChange(note1: notes[destinationIndexPath.row], note2: notes[sourceIndexPath.row], note1NewId: destinationIndexPath.row, note2NewId: sourceIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Note " + String(indexPath.row) + " clicked")
        guard let startVC = StartVC.StartVCRef else { return }
        let createNoteVC = startVC.LoadCreateNoteVC(.ViewMode)
        createNoteVC.editableTitle.text = notes[indexPath.row].title
        createNoteVC.editableText.text = notes[indexPath.row].description
        createNoteVC.noteIdx = indexPath
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            debugPrint("Deleting...")
            DeleteCell(indexPath: indexPath)
        }
    }
    
    
    func EnableEditMode(_ enable: Bool) {
        super.setEditing(enable, animated: true)
        table.setEditing(enable, animated: true)
        StartVC.OnEditMode = enable
    }
    
    
    func ModifyCell(noteTitle: String, noteContent: String, noteIdx: Int) {
        notes[noteIdx].title = noteTitle
        notes[noteIdx].description = noteContent
        self.table.reloadData()
    }
    func AddCell(noteTitle: String, noteContent: String) {
        let newNote = Note(title: noteTitle, description: noteContent, color: NamedUIColor(name: "White"))
        notes.append(newNote)
        self.table.reloadData()
    }
    func DeleteCell(indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        UserDefaults.RefresSavedNotesIndexes(notes: notes, startDeletionNoteIdx: indexPath.row)
    }
}

