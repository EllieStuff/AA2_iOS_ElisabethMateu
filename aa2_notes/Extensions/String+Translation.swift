//
//  String+Translation.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation

extension String {
    var Translated: String {
        get {
            let str = NSLocalizedString(self, tableName: "Translations", comment: "")
            if(str == self) { debugPrint("Esta traduccion no existe en el idioma X") }
            
            return str
        }
    }
}
