//
//  WeeklyWeatherForecastViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 18.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class WeeklyWeatherForecastViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var weekDaysScrollView: UIScrollView!
    @IBOutlet weak var weekDaysCollectionView: UICollectionView!
    @IBOutlet weak var currentWeatherIconImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentAdditionalWindSpeedLabel: UILabel!
    @IBOutlet weak var currentAdditionalPressureLabel: UILabel!
    @IBOutlet weak var currentAdditionalHumidityLabel: UILabel!
    @IBOutlet weak var currentAdditionalWindDegreeLabel: UILabel!
    @IBOutlet weak var firstTimeWeatherDescription: UILabel!
    @IBOutlet weak var secondTimeWeatherDescription: UILabel!
    @IBOutlet weak var thirdTimeWeatherDescription: UILabel!
    @IBOutlet weak var firstTimeWeatherTemperature: UILabel!
    @IBOutlet weak var secondTimeWeatherTemperature: UILabel!
    @IBOutlet weak var thirdTimeWeatherTemperature: UILabel!
    @IBOutlet weak var currentDayNameLabel: UILabel!
    
    // MARK: Properties
    var presenter: WeeklyWeatherForecastPresenterProtocol!
    private var model: [WeeklyHourlyWeatherForecast] = []
    
    // MARL: UIViewcontroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateWeather()
        setupRefreshControl()
    }
    
    // MARK: Setup UI
    
    private func setupRefreshControl() {
        weekDaysScrollView.refreshControl = UIRefreshControl()
        weekDaysScrollView.refreshControl?.addTarget(self, action: #selector(updateWeather), for: .valueChanged)
    }
    
    @objc func updateWeather() {
        presenter.updateWeather()
    }
    
    private func setupWeekDaysCollectionView() {
        let layout = weekDaysCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.minimumLineSpacing = 0
        
        let insetsAndLineSpacing = (self.view.bounds.width - (layout.minimumLineSpacing * CGFloat(model.count - 1)) - (layout.sectionInset.left * 2)) / CGFloat(model.count)
        
        layout.itemSize = CGSize(width: insetsAndLineSpacing, height: weekDaysCollectionView.frame.height * 0.85)
        weekDaysCollectionView.isScrollEnabled = false
        self.weekDaysCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func setupViews(_ index: Int) {
        self.currentWeatherIconImageView.image =
            self.model[index].weatherIcon
        self.currentDayNameLabel.text = self.model[index].weekDayName
        self.currentTemperatureLabel.text =
            String(format: "%.1f", self.model[index].currentDayTemperature).replacingOccurrences(of: ".", with: ",") + "°"
        self.currentAdditionalWindSpeedLabel.text =
            String(format: "%.1f", self.model[index].currentDayAdditionalInfo.windSpeed).replacingOccurrences(of: ".", with: ",") + " m/h"
        self.currentAdditionalWindDegreeLabel.text =
            String(format: "%.0f", self.model[index].currentDayAdditionalInfo.windDegree).replacingOccurrences(of: ".", with: ",") + " Deg"
        self.currentAdditionalHumidityLabel.text =
            String(format: "%.0f", self.model[index].currentDayAdditionalInfo.humidity).replacingOccurrences(of: ".", with: ",") + " %"
        self.currentAdditionalPressureLabel.text =
            String(format: "%.0f", self.model[index].currentDayAdditionalInfo.pressure).replacingOccurrences(of: ".", with: ",") + " PA"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        self.firstTimeWeatherTemperature.text =
            String(format: "%.1f", self.model[index].currentDayHourlyInfo[1].temperature).replacingOccurrences(of: ".", with: ",") + "°"
        self.secondTimeWeatherTemperature.text =
            String(format: "%.1f", self.model[index].currentDayHourlyInfo[0].temperature).replacingOccurrences(of: ".", with: ",") + "°"
        self.thirdTimeWeatherTemperature.text =
            String(format: "%.1f", self.model[index].currentDayHourlyInfo[2].temperature).replacingOccurrences(of: ".", with: ",") + "°"
        self.firstTimeWeatherDescription.text =
            self.model[index].currentDayHourlyInfo[1].temperatureDescription.capitalized
        self.secondTimeWeatherDescription.text =
            self.model[index].currentDayHourlyInfo[0].temperatureDescription.capitalized
        self.thirdTimeWeatherDescription.text =
            self.model[index].currentDayHourlyInfo[2].temperatureDescription.capitalized
    }
}

// MARK: DailyWeatherForecastViewProtocol conformation

extension WeeklyWeatherForecastViewController: WeeklyWeatherForecastViewProtocol {
    func showWeeklyWeatherForecast(_ weeklyWeatherForecast: [WeeklyHourlyWeatherForecast]) {
        self.weekDaysScrollView.refreshControl?.endRefreshing()
        self.model = weeklyWeatherForecast
        setupViews(0)
        self.weekDaysCollectionView.reloadData()
        setupWeekDaysCollectionView()
    }
}


// MARK: UICollectionViewDataSource

extension WeeklyWeatherForecastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                      for: indexPath) as! WeekDayWeatherCell
        cell.setup(for: model[indexPath.item].weekDayItem)
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension WeeklyWeatherForecastViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setupViews(indexPath.item)
    }
}
