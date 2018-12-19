//
//  GroceryItemCell.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/19/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import UIKit
import AlamofireImage

class GroceryItemCell: UITableViewCell {
    
    @IBOutlet weak var ui_title: UILabel!
    @IBOutlet weak var ui_description: UILabel!
    @IBOutlet weak var ui_image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func set(item: Grocery) {
        ui_title.text = item.title
        ui_description.text = item.subtitle
        if let url = URL(string: item.imageURL) {
            ui_image.af_setImage(withURL: url)
        } else {
            ui_image.image = #imageLiteral(resourceName: "tf_main")
        }
    }
    
}
