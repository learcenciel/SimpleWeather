//
//  SlideMenuCell.swift
//  SimpleWeather
//
//  Created by Alexander on 22.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SettingsMenuCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var menuItemDescription: UILabel!
    @IBOutlet weak var menuIconView: UIView!
    
    func setup(_ menuItem: String,
               _ menuItemDescription: String) {
        self.menuItemLabel.text = menuItem
        self.menuItemDescription.text = menuItemDescription
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowRadius = 3.0
        
        menuIconView.layer.cornerRadius = menuIconView.frame.height / 2
        menuIconView.clipsToBounds = true
    }
}
