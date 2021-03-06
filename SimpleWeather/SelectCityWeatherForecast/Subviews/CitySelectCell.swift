//
//  CitySelectCell.swift
//  SimpleWeather
//
//  Created by Alexander on 29.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class CitySelectCell: UITableViewCell {
    
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentCityImageView: UIImageView!
    
    func select(_ selected: Bool) {
        if selected {
            cardView.backgroundColor = UIColor(named: "Selected City Cell Background Color")
            cityNameLabel.textColor = UIColor(named: "Selected City Cell Text Color")
            currentCityImageView.tintColor = UIColor(named: "Selected City Cell Icon Color")
        } else {
            cardView.backgroundColor = UIColor(named: "Unselected City Cell Background Color")
            cityNameLabel.textColor = UIColor(named: "Unselected City Cell Text Color")
            currentCityImageView.tintColor = UIColor(named: "Unselected City Cell Icon Color")
        }
    }
    
    func setup(city: RealmCity) {
        currentCityImageView.tintColor = UIColor(named: "additionalInfoValueLabelColor")
        currentCityImageView.isHidden = !city.isCurrent
        cityNameLabel.text = city.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowRadius = 3.0
    }
}
