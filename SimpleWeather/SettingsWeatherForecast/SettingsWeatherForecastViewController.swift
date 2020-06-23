//
//  SlideMenuTableViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 22.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SettingsWeatherForecastViewController: UIViewController {
    
    private enum CellType: String, CaseIterable {
        case chooseCity = "Search City"
        case selectExistingCity = "Select City"
        case aboutApp = "About App"
    }
    
    @IBOutlet weak var tv: UITableView!
    var presenter: SettingsWeatherForecastPresenterProtocol!
    
    let menuItems: [SettingsMenuItem] =
        [SettingsMenuItem(menuItemTitle: CellType.chooseCity.rawValue,
                          menuItemDescription: "Search a new city",
                          menuItemIcon: "settings_location_icon"),
         SettingsMenuItem(menuItemTitle: CellType.selectExistingCity.rawValue,
                          menuItemDescription: "Select Existing City",
                          menuItemIcon: "settings_about_icon"),
         SettingsMenuItem(menuItemTitle: CellType.aboutApp.rawValue,
                          menuItemDescription: "About this app",
                          menuItemIcon: "settings_about_icon")]
}

extension SettingsWeatherForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tv.cellForRow(at: indexPath),
            let cellTitleText = (cell as? SettingsMenuCell)?.menuItemLabel.text,
            let cellType = CellType(rawValue: cellTitleText)
            else { return }
        
        switch cellType {
        case .chooseCity:
            presenter.showCityChooser()
        case .selectExistingCity:
            print("Select")
        case .aboutApp:
            print("About")
        }
    }
}

extension SettingsWeatherForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SettingsMenuCell
        
        cell.setup(menuItem: self.menuItems[indexPath.row])
        print("kek")
        return cell
    }
}

extension SettingsWeatherForecastViewController: SettingsWeatherForecastViewProtocol {
    func didSelectCurrentCity() {
        print("nice")
    }
}
