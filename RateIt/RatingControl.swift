//
//  RatingControl.swift
//  RateIt
//
//  Created by Nikita Vesna on 28.05.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    @IBOutlet weak var ratingTF: UITextField!
    
    //MARK: Properties
    
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Actions
    
    @objc func ratingBtnPressed(button: UIButton) {
        
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        //Calculate rating of selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 1
            ratingTF.text = "~/10"
        } else {
            rating = selectedRating
            ratingTF.text = "\(selectedRating)/10"
        }
        
        
    }
    
    //MARK: Private methods
    
    private func setupButtons() {
        
        //Pre-cleaning
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        //Load button image
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        let hightlightedStar = UIImage(named: "hightlightedStar",
                                       in: bundle,
                                       compatibleWith: self.traitCollection)
        
        
        
        //Creating new buttons
        for _ in 0 ..< starCount {
            let button = UIButton()
            
            //Set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(hightlightedStar, for: .highlighted)
            button.setImage(hightlightedStar, for: [.highlighted, .selected])
            
            //Constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Setup btn action
            button.addTarget(self, action: #selector(ratingBtnPressed(button: )), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
            
        }
        
        updateButtonSelectionState()
        
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
