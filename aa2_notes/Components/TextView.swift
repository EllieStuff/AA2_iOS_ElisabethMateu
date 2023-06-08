//
//  TextView.swift
//  aa2_notes
//
//  Created by Alumne on 30/5/23.
//

import Foundation
import UIKit

class TextView: UITextView {
    
    init(_ text: String = "", style: UIFont.TextStyle = .body) {
        super.init(frame: .zero, textContainer: nil)
        
        self.EnableConstraints()
        
        self.text = text
        
        self.adjustsFontForContentSizeCategory = true
        
        self.isUserInteractionEnabled = false
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
