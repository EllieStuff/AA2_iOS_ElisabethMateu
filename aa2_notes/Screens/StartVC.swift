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
        
        let title: UITextField = UITextField()
        title.text = Label("NotesTitle".Translated).text
        titleView.addSubview(title)
        title.EnableConstraints()
            .AlingBotTo(titleView, padding: 20)
            .CenterXTo(titleView.centerXAnchor)
        
        let editBttn = Button(Label("EditBttn", style: .caption1)) { button in
            
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
        //notesView.PinTo(other: self.view)
        notesView.EnableConstraints()
            .AlingRightTo(self.view)
            .AlingLeftTo(self.view)
            .AlingTopTo(titleView, padding: 120) //ToDo: Poner que se puede poner si alinear arriba o abajo de view con booleana
            .AlingBotTo(self.view)
        
        let table = Table()
        notesView.addSubview(table.view)
        table.view.PinTo(other: notesView)
        
        
        let addNoteBttn = Button(Label("+")) { button in
            debugPrint("+ Pressed")
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


}

class Table: VC, UITableViewDelegate, UITableViewDataSource {
    
    var notes: [Note] = [
        Note(title: "Note1", description: "djksf", color: NamedUIColor(name: "Purple"), type: .Work),
        Note(title: "Note2", description: "djkfdbvsf djkfdbvsf djkfdbvsf djkfdbvsf", color: NamedUIColor(name: "White"), type: .Shop)
    ]
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(table)
        table.PinTo(other: self.view)
        
        table.delegate = self
        table.dataSource = self
        
        table.register(NoteCell.self, forCellReuseIdentifier: NoteCell.Id)
        
        table.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        //Cosas
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NoteCell.CellSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        debugPrint("note clicked 1")
        if let notesOptions = storyboard.instantiateViewController(withIdentifier: NoteCell.Id) as? NoteCell {
            debugPrint("note clicked 2")
            //HeroDetailVC.CurrHero = heroesLoaded[indexPath.row]
            //heroDetailVC.modalPresentationStyle = .overFullScreen
            
            //self.present(heroDetailVC, animated: true)
        }
    }
}


/*protocol TableViewCell: UITableView {
    var Id: String { get }
    
}

class MyCell: UITableView, TableViewCell {
    var Id: String {
        return "MyCell"
    }
    
}*/

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
