//
//  AddItemViewController.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/18/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var ui_title: UITextField!
    @IBOutlet weak var ui_subtitle: UITextField!
    @IBOutlet weak var ui_imageURL: UITextField!
    @IBOutlet weak var ui_button: UIButton!
    
    var isEdit: Bool?
    var groceryItem: Grocery?
    
    let ref = Database.database().reference(withPath: "grocery-items")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let edit = isEdit, edit {
            self.title = "Edit Item"
            ui_button.setTitle("Update", for: .normal)
            if let item = groceryItem {
                ui_title.text = item.title
                ui_subtitle.text = item.subtitle
                ui_imageURL.text = item.imageURL
            }
        } else {
            self.title = "Add Item"
        }
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        guard let
            title = ui_title.text,
            let subtitle = ui_subtitle.text,
            let imageURL = ui_imageURL.text,
            title != "", subtitle != "", imageURL != "" else { return }
    
        if let edit = isEdit, let itemReference = groceryItem, edit {
            // Case Editing
            itemReference.ref?.updateChildValues([
                "title" : title,
                "subtitle" : subtitle,
                "imageURL" : imageURL
                ])
        } else {
            // Case Adding
            let obj = Grocery(title: title, subtitle: subtitle, imageURL: imageURL)
            self.ref.childByAutoId().setValue(obj.toDictionary())
        }
        navigationController?.popViewController(animated: true)

    }
    
}
