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
    var type: NoteType
    
    var Color: UIColor {
        get {
            switch(type){
            case .Shop:
                return UIColor(named: "Yellow") ?? .clear
            case .Work:
                return UIColor(named: "Purple") ?? .clear
            }
        }
    }
}

