//
//  ShadowView.swift
//  CheckMyLiquid
//
//  Created by Hirusha Ravishan on 2024-04-18.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 15
        
        //Shadows
        
        layer.shadowColor = UIColor(red: 0.403, green: 0.394, blue: 0.867, alpha: 0.1).cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 7)
    }

}
