//
//  NoteCell.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 7/6/23.
//

import Foundation
import UIKit

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
