//
//  Model.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/18/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Grocery {
    
    var ref: DatabaseReference?
    var title: String = ""
    var subtitle: String = ""
    var imageURL: String = ""
    
    init(title: String, subtitle: String, imageURL: String) {
        self.ref = nil
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let subtitle = value["subtitle"] as? String,
            let imageURL = value["imageURL"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
    func toDictionary() -> Any {
        return ["title": title, "subtitle": subtitle, "imageURL": imageURL] as Any
    }
    
}
