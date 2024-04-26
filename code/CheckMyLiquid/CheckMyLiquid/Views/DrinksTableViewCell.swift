//
//  DrinksTableViewCell.swift
//  CheckMyLiquid
//
//  Created by Hirusha Ravishan on 2024-04-18.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var drink: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.layer.backgroundColor = UIColor.white.cgColor
        cellBackgroundView.layer.cornerRadius = 15
        
        //Shadows
        
        cellBackgroundView.layer.shadowColor = UIColor(red: 0.403, green: 0.394, blue: 0.867, alpha: 0.1).cgColor
        cellBackgroundView.layer.shadowRadius = 1
        cellBackgroundView.layer.shadowOpacity = 1
        cellBackgroundView.layer.shadowOffset = CGSize(width: 1, height: 7)
    }

   

}
