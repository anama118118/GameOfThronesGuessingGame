//
//  DetailViewController.swift
//  GameOfThrones2
//
//  Created by Ana Ma on 12/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedBook: Book!
    var character: Character?
    var house: [House] = []
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var houseInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.houseInfoLabel.isHidden = true
        self.houseInfoLabel.text = "None"
        let randomNum = arc4random_uniform(UInt32(selectedBook.characters.count))
        APIRequestManager.shared.getData(endpoint: selectedBook.characters[Int(randomNum)]) { (data: Data?) in
            guard let validData = data else { return }
            DispatchQueue.main.async {
                self.character = Character.getCharacter(data: validData)
                self.characterNameLabel.text = "Which house does \(self.character!.name) come from?"
                self.getHouse()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHouse() {
        if (self.character?.allegiances)! != [] {
            for house in (self.character?.allegiances)! {
                APIRequestManager.shared.getData(endpoint: house, completion: { (data: Data?) in
                    guard let validData = data else { return }
                    guard let house =  House.getHouse(data: validData) else { return }
                    self.house.append(house)
                })
            }
        }
    }
    
    @IBAction func showAnswerButtonAction(_ sender: UIButton) {
        var text = ""
        for h in self.house {
            text += "\(h.name) \n"
        }
        if text != "" {
            self.houseInfoLabel.text = text
        }
        self.houseInfoLabel.isHidden = false
        
    }
    

}
