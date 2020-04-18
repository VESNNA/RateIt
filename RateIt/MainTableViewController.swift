//
//  MainTableViewController.swift
//  RateIt
//
//  Created by Nikita Vesna on 05.12.2019.
//  Copyright © 2019 Nikita Vesna. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var reviews: Results<Review>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviews = realm.objects(Review.self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.isEmpty ? 0 : reviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        
        let review = reviews[indexPath.row]
        
        cell.mainFirstLbl.text = review.name
        cell.mainSecondLbl.text = review.category
        cell.mainThirdLbl.text = review.date
        cell.thumbnailImageView.image = UIImage(data: review.imageData!)
        
        //TODO: add this parameter as optional to constructor
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let review = reviews[indexPath.row]
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
            StorageManager.deleteObject(review)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newReviewVC = segue.source as? NewReviewTableViewController else {return}
        
        newReviewVC.saveNewReview()
        tableView.reloadData()
    }

}
