//
//  PlacesVietnam.swift
//  Demo
//
//  Created by Đừng xóa on 8/24/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

class PlacesVietNam {
    var name: String
    var image: String
    var content: String
    var place: String
    
    
    init?(dictionary: DICT) {
        guard let name = dictionary["name"] as? String else { return nil }
        guard let image = dictionary["image"] as? String else { return nil }
        guard let content = dictionary["content"] as? String else { return nil }
        guard let place = dictionary["place"] as? String else { return nil }
        
        self.name = name
        self.image = image
        self.content = content
        self.place = place
    }
}
