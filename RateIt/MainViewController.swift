//
//  MainViewController.swift
//  RateIt
//
//  Created by Nikita Vesna on 05.12.2019.
//  Copyright © 2019 Nikita Vesna. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let searchController=UISearchController(searchResultsController: nil)
    private var ascendingSorting = true
    private var reviews: Results<Review>!
    private var filtredReviews: Results<Review>!
    private var index: IndexPath?
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reverseSortingBtn: UIBarButtonItem!
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint! //uses to hide segmented control
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviews = realm.objects(Review.self)
        
        //Setup Search Controller //TODO: Hide SearchBar on default, show on swipe
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredReviews.count
        }
        return reviews.isEmpty ? 0 : reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        
        var review = Review()
        
        //TODO: Edit tableViewTopConstraint when searchBarIsActive
        //tableViewTopConstraint.constant -= CGFloat(44)
        if isFiltering {
            review = filtredReviews[indexPath.row]
        } else {
            review = reviews[indexPath.row]
        }
        
        cell.mainFirstLbl.text = review.name
        cell.mainSecondLbl.text = review.category
        cell.thumbnailImageView.image = UIImage(data: review.imageData!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" //"dd.MM.yy"
        let dateString = dateFormatter.string(from: review.date as Date)
        cell.mainThirdLbl.text = dateString
        
        //TODO: add this parameter as optional to constructor
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let review = reviews[indexPath.row]
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
            StorageManager.deleteObject(review)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            
            self.index = indexPath
            self.performSegue(withIdentifier: "editSegue", sender: nil)
            
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editSegue" {
            let indexP = index
            var review: Review
            if isFiltering {
                review = filtredReviews[indexP!.row]
            } else {
                review = reviews[indexP!.row]
            }
            
            let editVC = segue.destination as! NewReviewTableViewController
            editVC.currentReview = review
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newReviewVC = segue.source as? NewReviewTableViewController else {return}
        
        newReviewVC.saveReview()
        tableView.reloadData()
    }
    
    @IBAction func sortingSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reverseSorting(_ sender: UIBarButtonItem) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reverseSortingBtn.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverseSortingBtn.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
    }
    
    private func sorting() {
        if sortingSegmentedControl.selectedSegmentIndex == 0 {
            reviews = reviews.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            reviews = reviews.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filtredReviews = reviews.filter("name CONTAINS[c] %@ OR category CONTAINS[c] %@", searchText, searchText)
        
        tableView.reloadData()
    }
}
