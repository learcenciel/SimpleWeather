//
//  SlideMenuTableViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 22.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SettingsWeatherForecastViewController: UIViewController {

    let menuItems = ["Choose City", "About"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsWeatherForecastViewController: UITableViewDelegate {
    
}

extension SettingsWeatherForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SettingsMenuCell
        
        cell.setup(menuItems[indexPath.row])
        
        return cell
    }
    
    
}
