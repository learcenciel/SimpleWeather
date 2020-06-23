//
//  SettingsWeatherForecastRouter.swift
//  SimpleWeather
//
//  Created by Alexander on 23.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import GooglePlaces
import UIKit

class SettingsWeatherForecastRouter: SettingsWeatherForecastRouterProtocol {
    
    var container: DIContainer
    var presenter: SettingsWeatherForecastPresenterProtocol
    
    init(container: DIContainer,
         presenter: SettingsWeatherForecastPresenterProtocol) {
        self.container = container
        self.presenter = presenter
    }
    
    func presentCityChooser(from view: SettingsWeatherForecastViewProtocol) {
        if let viewController = view as? UIViewController {
            
            let autocompleteController = GMSAutocompleteViewController()
            
            if #available(iOS 13.0, *) {
                if UIScreen.main.traitCollection.userInterfaceStyle == .dark  {
                    autocompleteController.primaryTextColor = UIColor.white
                    autocompleteController.secondaryTextColor = UIColor.lightGray
                    autocompleteController.tableCellSeparatorColor = UIColor.lightGray
                    autocompleteController.tableCellBackgroundColor = UIColor.darkGray
                } else {
                    autocompleteController.primaryTextColor = UIColor.black
                    autocompleteController.secondaryTextColor = UIColor.lightGray
                    autocompleteController.tableCellSeparatorColor = UIColor.lightGray
                    autocompleteController.tableCellBackgroundColor = UIColor.white
                }
            }
            
            autocompleteController.delegate = presenter
            
            // Specify the place data types to return.
            let fields: GMSPlaceField =
                GMSPlaceField(rawValue:
                    UInt(GMSPlaceField.name.rawValue) |
                        UInt(GMSPlaceField.placeID.rawValue) |
                        UInt(GMSPlaceField.coordinate.rawValue))!
            autocompleteController.placeFields = fields
            
            // Specify a filter.
            let filter = GMSAutocompleteFilter()
            filter.type = .city
            autocompleteController.autocompleteFilter = filter
            
            // Display the autocomplete view controller.
            viewController.present(autocompleteController, animated: true, completion: nil)
        }
    }
}
