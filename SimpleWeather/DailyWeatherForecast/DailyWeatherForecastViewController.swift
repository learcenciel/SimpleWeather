//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class DailyWeatherForecastViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var dashedCircleVIew: DashedCircleView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var daySelectedSegmentedControl: DaySelectControl!
    @IBOutlet weak var currentWeatherIconImageView: UIImageView!
    @IBOutlet weak var currentWeatherTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherCityNameLabel: UILabel!
    @IBOutlet weak var dailyHourlyForecastCollectionView: UICollectionView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windDegLabel: UILabel!
    
    // MARK: Properties
    
    var weatherForecast: WeatherForecast?
    var presenter: DailyWeatherForecastPresenterProtocol!
    
    var isContentLoaded = false
    var isDashedCircleViewAnimationNeedShow = true
    
    var sunrise = Date()
    var sunset = Date()
    var currentTime = Date()
    var timeZone = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupRefreshControl()
        presenter.viewDidLoad()
        showLoading()
    }
    
    // MARK: UI setup
    
    func showLoading() {
        view.subviews.forEach { $0.isHidden = !$0.isHidden }
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        tabBarController?.tabBar.isHidden = true
    }
    
    func showContent() {
        isContentLoaded = true
        view.subviews.forEach { $0.isHidden = !$0.isHidden }
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupRefreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(updateWeather), for: .valueChanged)
    }
    
    func setupCollectionView() {
        let flowLayout = dailyHourlyForecastCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        flowLayout.minimumLineSpacing = 48
    }
    
    @objc func updateWeather() {
        presenter.updateWeather()
    }
    
    func isDashedCircleViewVisible(view: UIView) -> Bool {
        
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            
            guard let inView = inView else { return true }
            
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            
            return false
        }
        
        return isVisible(view: view, inView: view.superview)
    }
    
    func getCurrentTime() -> Date {
        return NSDate() as Date
    }
    
    func checkIfTimeInRange(_ currentTime: Date) -> Bool {
        return currentTime >= self.sunrise && currentTime <= self.sunset
    }
}

// MARK: DailyWeatherForecastViewProtocol conformation

extension DailyWeatherForecastViewController: DailyWeatherForecastViewProtocol {
    
    func showCurrentWeather(with currentWeather: WeatherForecast) {
        
        if isContentLoaded == false { showContent() }
        
        guard let refreshControl = scrollView.refreshControl else { return }
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
        
        self.weatherForecast = currentWeather
        self.currentWeatherIconImageView.image = currentWeather.weatherIcon
        self.currentWeatherTemperatureLabel.text = currentWeather.currentTemperature.getTemperature()
        self.currentWeatherCityNameLabel.text = currentWeather.cityName
        self.windLabel.text = currentWeather.currentAdditionalInfo.wind.getWindSpeed()
        self.humidityLabel.text = currentWeather.currentAdditionalInfo.humidity.getHumidity()
        self.pressureLabel.text = currentWeather.currentAdditionalInfo.pressure.getPressure()
        self.windDegLabel.text = currentWeather.currentAdditionalInfo.windDeg.getWindDegree()
        self.sunrise = currentWeather.sunrise
        self.sunset = currentWeather.sunset
        self.timeZone = currentWeather.timeZone
        
        dailyHourlyForecastCollectionView.reloadData()
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension DailyWeatherForecastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let numberofItem: CGFloat = 3
        
        let collectionViewWidth = collectionView.bounds.width
        
        let extraSpace = (numberofItem - 1) * flowLayout.minimumLineSpacing
        
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let width = (collectionViewWidth - extraSpace - inset) / numberofItem
        
        return CGSize(width: width, height: dailyHourlyForecastCollectionView.bounds.size.height * 0.7)
    }
}

// MARK: UICollectionViewDelegate

extension DailyWeatherForecastViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            if isDashedCircleViewVisible(view: dashedCircleVIew) {
                if isDashedCircleViewAnimationNeedShow {
                    
                    let currentTime = getCurrentTime()
                    let isTimeInRange = checkIfTimeInRange(currentTime)
                    let cur = isTimeInRange ? currentTime : self.sunset
                    
                    dashedCircleVIew.animate(sunrise: self.sunrise,
                                             sunset: self.sunset,
                                             currentTime: cur,
                                             timeZone: self.timeZone)
                    
                    isDashedCircleViewAnimationNeedShow = false
                }
            } else {
                isDashedCircleViewAnimationNeedShow = true
            }
        } else {
            
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2
            
            daySelectedSegmentedControl.selectedIndex = Int(offSet + horizontalCenter) / Int(width)
        }
    }
}

// MARK: UICollectionViewDataSource

extension DailyWeatherForecastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (weatherForecast?.futureDays.count ?? 0) / 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (weatherForecast?.futureDays.count ?? 0) / 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCardCell", for: indexPath) as? DayCardCell
            else { fatalError() }
        
        guard
            let dayWeather = weatherForecast?.futureDays[indexPath.section * 3 + indexPath.item]
            else { fatalError() }
        
        cell.bind(dayWeather,
                  cardType: CardType.allCases[indexPath.item])
        
        return cell
    }
}
