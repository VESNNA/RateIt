//
//  MainTableViewCell.swift
//  RateIt
//
//  Created by Nikita Vesna on 05.12.2019.
//  Copyright © 2019 Nikita Vesna. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var mainFirstLbl: UILabel!
    @IBOutlet weak var mainSecondLbl: UILabel!
    @IBOutlet weak var mainThirdLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
