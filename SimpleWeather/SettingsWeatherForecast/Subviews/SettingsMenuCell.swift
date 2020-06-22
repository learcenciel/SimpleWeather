//
//  SlideMenuCell.swift
//  SimpleWeather
//
//  Created by Alexander on 22.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SettingsMenuCell: UITableViewCell {

    @IBOutlet weak var menuItemLabel: UILabel!

    func setup(_ menuItem: String) {
        self.menuItemLabel.text = menuItem
    }
}
