//
//  GameOfThronesTableViewController.swift
//  GameOfThrones2
//
//  Created by Ana Ma on 12/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

//https://anapioficeandfire.com/

class GameOfThronesTableViewController: UITableViewController {
    
    let gotCellIdentifier = "gotCellIdentifier"
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.shared.getData(endpoint: "http://www.anapioficeandfire.com/api/books") { (data: Data?) in
            guard let validData = data else { return }
            DispatchQueue.main.async {
                self.books = Book.getBooks(data: validData)!
                self.tableView.reloadData()
                dump(validData)
                dump(self.books)
                print(self.books.count)
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.books.count
    }
    
    //https://github.com/C4Q/AC3.2/tree/master/lessons/unit3/url
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.gotCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = books[indexPath.row].name
        cell.detailTextLabel?.text = books[indexPath.row].mediaType
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewControllerSegue",
            let detailViewController = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            let selectedBook = books[(indexPath.row)]
            detailViewController.selectedBook = selectedBook
        }
    }
    
    //        if segue.identifier == "detailViewControllerSegue"{
    //            let detailViewController = segue.destination as! DetailViewController
    //            if let cell = sender as? UITableViewCell {
    //                if let indexPath = tableView.indexPath(for: cell) {
    //                    let selectedBook = books[(indexPath.row)]
    //                    detailViewController.selectedBook = selectedBook
    //                }
    //            }
    //        }
    
    /*
    func loadData() {
        guard let path = Bundle.main.path(forResource: "violations", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
            let violationsJSON = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSArray else {
                return
        }
        
        if let violations = violationsJSON as? [[String:String]] {
            for violationDict in violations {
                if let ep = Violation(withDict: violationDict) {
                    self.records.append(ep)
                }
            }
        }
    }
    */
}
