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
    @IBOutlet weak var dayWeatherIcon: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            setSelected()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    func setup(for weekDayItem: WeekDayItem) {
        self.dayTitle.text = weekDayItem.name
        self.dayWeatherIcon.image = weekDayItem.weatherIcon.withRenderingMode(.alwaysTemplate)
        if isSelected {
            self.dayWeatherIcon.tintColor = UIColor(named: "SelectedDayColor")
        } else {
            self.dayWeatherIcon.tintColor = UIColor(named: "UnselectedDayColor")
        }
    }
    
    private func setSelected() {
        if isSelected {
            self.dayWeatherIcon.tintColor = UIColor(named: "SelectedDayColor")
            self.dayTitle.textColor = UIColor(named: "SelectedDayColor")
        } else {
            self.dayWeatherIcon.tintColor = UIColor(named: "UnselectedDayColor")
            self.dayTitle.textColor = UIColor(named: "UnselectedDayColor")
        }
    }
}
