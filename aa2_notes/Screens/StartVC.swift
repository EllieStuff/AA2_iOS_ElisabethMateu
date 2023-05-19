//
//  ViewController.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import UIKit

class StartVC: VC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let codeView = UIView()
        codeView.backgroundColor = .red
        self.view.addSubview(codeView)
        
        codeView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = codeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        centerX.isActive = true
        
        codeView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([codeView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
                                     NSLayoutConstraint(item: codeView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.75, constant: 0)])
        
        let otherView = UIView()
        otherView.backgroundColor = .green
        self.view.addSubview(otherView)
        
        otherView.PinTo(other: codeView, padding: .space8)
        
        let bttnWithLabel = Button(Label("HelloWorld".Translated)) {
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
        
        //UserDefaults.standard.setValue(Note(title: "Nota 1", description: "Esta es la primera nota que guardo", type: .Shop).JSON, forKey: "Nota1")
        
    }


}

