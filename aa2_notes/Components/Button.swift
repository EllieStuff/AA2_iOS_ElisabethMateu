//
//  Button.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation
import UIKit

class Button: UIView {
    
    var label: Label?
    typealias OnClick = () -> ()
    var onClick: OnClick = {}
    
    init(_ label: Label? = nil, _ onClick: @escaping OnClick = {}) {
        super.init(frame: .zero)
        
        self.EnableConstraints()
        
        self.label = label
        if let label = self.label {
            self.addSubview(label)
            label.PinTo(other: self)
        }
        
        self.onClick = onClick
        self.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.OnTap))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func OnTap() {
        self.onClick()
    }
    
}
