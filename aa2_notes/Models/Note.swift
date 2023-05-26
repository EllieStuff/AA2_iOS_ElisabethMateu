//
//  Note.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation
import UIKit

struct Note: Codable {
    
    enum NoteType: Codable {
        case Shop
        case Work
    }
    
    var title: String
    var description: String
    var color: NamedUIColor
    var type: NoteType
    
}

struct NamedUIColor: Codable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var Color: UIColor? {
        return UIColor(named: name)
    }
    
    static var BgPrincipal: NamedUIColor {
        return NamedUIColor(name: "BgPrincipal")
    }
}

