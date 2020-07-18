//
//  AboutAppViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 01.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UILabel!
    let aboutApp = "This app is created for study purposes, it uses free API service - OpenWeatherMap. Please, enjoy"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutLabel.text = aboutApp
    }
}
