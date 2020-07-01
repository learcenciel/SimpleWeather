//
//  SelectCityWeatherForecastViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 28.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SelectCityWeatherForecastViewController: UIViewController {
    var presenter: SelectCityWeatherForecastPresenterProtocol!
    @IBOutlet weak var citiesTableView: UITableView!
    var cities: [RealmCity] = []
    var selectedCities: [RealmCity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupGestures()
    }
    
    func setupGestures() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(editCitiesTableView))
        citiesTableView.addGestureRecognizer(longPressGesture)
        citiesTableView.isUserInteractionEnabled = true
        citiesTableView.allowsMultipleSelection = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCity))
        citiesTableView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    @objc func selectCity(_ sender: UITapGestureRecognizer) {
        if isEditing == false { return }
        
        guard
            let indexPath = citiesTableView.indexPathForRow(at: sender.location(in: sender.view)),
            let cell = citiesTableView.cellForRow(at: indexPath) as? CitySelectCell
        else { return }
        
        if cell.isSelected {
            cell.select(false)
            citiesTableView.deselectRow(at: indexPath, animated: true)
        } else {
            cell.select(true)
            citiesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
    @objc func deleteSelectedCities() {
        guard
            let selectedRowsIndexPaths = citiesTableView.indexPathsForSelectedRows
        else { return }
        var selectedCities: [RealmCity] = []
        selectedCities = []

        for indexPath in selectedRowsIndexPaths {
            selectedCities.append(cities[indexPath.row])
            cities.remove(at: indexPath.row)
        }
        presenter.delete(selectedCities)

        citiesTableView.beginUpdates()
        citiesTableView.deleteRows(at: selectedRowsIndexPaths, with: .automatic)
        citiesTableView.endUpdates()
        
        if cities.count == 0 { dismiss(animated: true, completion: nil) }
    }
    
    @objc func doneEditing() {
        isEditing = false
        let visibleCells = citiesTableView.visibleCells.compactMap { $0 as? CitySelectCell }
        let visibleSelectedCells = visibleCells.filter { $0.isSelected }
        visibleSelectedCells.forEach { cell in
            cell.select(isEditing)
        }
        navigationController?.setToolbarHidden(!isEditing, animated: true)
    }
    
    @objc func editCitiesTableView(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            if isEditing { return }
            isEditing = true
            guard
                let indexPath = citiesTableView.indexPathForRow(at: sender.location(in: sender.view)),
                let cell = citiesTableView.cellForRow(at: indexPath) as? CitySelectCell
            else { return }
            cell.select(true)
            citiesTableView.selectRow(at: indexPath, animated: true,
                                      scrollPosition: .none)
            
            let delete = UIBarButtonItem(barButtonSystemItem: .trash,
                                         target: self, action: #selector(deleteSelectedCities))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            let done = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(doneEditing))
            toolbarItems = [delete, flexibleSpace, done]
            navigationController?.setToolbarHidden(!isEditing, animated: true)
        default:
            break
        }
    }
}

// MARK: SelectCityWeatherForecastViewProtocol conformation

extension SelectCityWeatherForecastViewController: SelectCityWeatherForecastViewProtocol {
    func didRetreieveCitiesFromDatabase(_ cities: [RealmCity]) {
        self.cities = cities
        self.citiesTableView.reloadData()
    }
    
    func didSelectCurrentCity() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource

extension SelectCityWeatherForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CitySelectCell
        cell.setup(city: cities[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension SelectCityWeatherForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectCurrent(cities[indexPath.row])
    }
}

// MARK: UIGestureRecognizerDelegate

extension SelectCityWeatherForecastViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        isEditing ? true : false
    }
}

