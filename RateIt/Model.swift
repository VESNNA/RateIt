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
    @objc dynamic var date: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var rating: String?
    @objc dynamic var review: String?
    
    //TODO: Some lists feature
    @objc dynamic var list: Int = 0
    
    
    convenience init(name: String, category: String?, date: String?, imageData: Data?, rating: String?, review: String?, list: Int) {
        self.init()
        self.name = name
        self.category = category
        self.date = date
        self.imageData = imageData
        self.rating = rating
        self.review = review
        self.list = list
    }
}

/*
 let image = UIImage(named: )
 guard let imageData = image?.pngData() else {return}
 
 let newReview = Review()
 
 newReview.name
 newReview.category
 newReview.date
 newReview.imageData
 newReview.rating
 newReview.review
 
 newReview.list = 0
 
 storageManager.saveObject(newReview)
 */
