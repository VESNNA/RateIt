//
//  MainTableViewController.swift
//  RateIt
//
//  Created by Nikita Vesna on 05.12.2019.
//  Copyright © 2019 Nikita Vesna. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var reviews = [Review(name: "Elu", secondField: "01", date: "03", image: nil)]
    
    //let reviews = [Review(list: 0, category: "Rest", name: "Elu", image: nil, rating: 10.0, review: "Good", date: "01-01-01")]

    
    //let itemsNames = ["Ogonёk Grill&Bar", "Елу", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Respublica", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
    
    //let itemsImages = ["ogonek.jpg", "elu.jpg", "bonsai.jpg", "dastarhan.jpg", "indokitay.jpg", "x.o.jpg", "balkan.jpg", "respublika.jpg", "speakeasy.jpg", "morris.jpg", "istorii.jpg", "klassik.jpg", "love.jpg", "shok.jpg", "bochka.jpg"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        
        let review = reviews[indexPath.row]
        
        cell.mainFirstLbl.text = review.name
        cell.mainSecondLbl.text = review.secondField
        cell.mainThirdLbl.text = review.date
        
        if let image = review.image {
            cell.thumbnailImageView.image = image
            
            //TODO: add this parameter as optional to constructor
            cell.thumbnailImageView.layer.cornerRadius = 32.5
            cell.thumbnailImageView.clipsToBounds = true
        }
        
        
        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newReviewVC = segue.source as? NewReviewTableViewController else {return}
        
        newReviewVC.saveNewReview()
        
        reviews.append(newReviewVC.newReview!)
        
        tableView.reloadData()
    }

}
