//
//  SlideMenuTableViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 22.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SettingsWeatherForecastViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    let menuItems = ["Choose City", "About"]
    let menuItemDescriptions = ["Choose current city", "About this app"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
        cell.setup(menuItems[indexPath.row],
                   menuItemDescriptions[indexPath.row])
        
        return cell
    }
    
    
}
