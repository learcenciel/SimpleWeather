//
//  WeekDayWeatherCell.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class WeekDayWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var dayTitle: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            self.dayTitle.textColor = UIColor(named: "SelectedDayColor")
        } else {
            self.dayTitle.textColor = UIColor(named: "UnselectedDayColor")
        }
    }
}
