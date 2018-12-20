//
//  ViewController.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/18/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ui_addButton: UIButton!
    
    var ref: DatabaseReference!
    var groceryList: [Grocery] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        ref = Database.database().reference(withPath: "grocery-items")
        fetchFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFirebase()
    }
    
    // Function when add new item button is clicked
    @IBAction func addItemClicked(_ sender: UIButton) {
               if let vc = storyboard?.instantiateViewController(withIdentifier: "ref_additem") as? AddItemViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Attach Firebase listener to this screen, monitoring for value changes
    private func fetchFirebase() {
        ref.observe(.value, with: { (snapshot) in
            var newItem: [Grocery] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let item = Grocery(snapshot: snapshot) {
                    newItem.append(item)
                }
            }
            self.groceryList = newItem
            self.tableView.reloadData()
        })
    }
    
    // Configuring the tableView
    private func configureTableView() {
        tableView.register(UINib(nibName: "GroceryItemCell", bundle: Bundle.main) , forCellReuseIdentifier: "ref_groceryitemcell")
    }

}

// Function required for creating tableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Populating tableView cells for each item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ref_groceryitemcell") as? GroceryItemCell {
            cell.set(item: groceryList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // Set size for each tableView cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // Get number of item in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    // Add action button for each tableView cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Edit action
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action: UITableViewRowAction, indexPath: IndexPath) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ref_additem") as? AddItemViewController {
                vc.isEdit = true
                vc.groceryItem = self.groceryList[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // Delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let groceryItem = self.groceryList[indexPath.row]
            groceryItem.ref?.removeValue()
        }
        
        return [deleteAction, editAction]
    }
    
}

