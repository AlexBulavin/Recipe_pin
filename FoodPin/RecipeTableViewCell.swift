//
//  RecipeTableViewCell.swift
//  FoodPin
//
//  Created by Alex on 19.03.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!

    @IBOutlet var heartImageView: UIImageView!
    
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet {
    thumbnailImageView.layer.cornerRadius = 8.0
    thumbnailImageView.clipsToBounds = true }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
