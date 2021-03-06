//
//  Model.swift
//  RateIt
//
//  Created by Nikita Vesna on 03.03.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import RealmSwift

class Review: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var category: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var rating = 0.0
    @objc dynamic var review: String?
    @objc dynamic var date = Date()
    
    //TODO: Some lists feature
    @objc dynamic var list: Int = 0
    
    
    convenience init(name: String, category: String?, imageData: Data?, rating: Double, review: String?, list: Int) {
        self.init()
        self.name = name
        self.category = category
        self.imageData = imageData
        self.rating = rating
        self.review = review
        self.list = list
    }
}
