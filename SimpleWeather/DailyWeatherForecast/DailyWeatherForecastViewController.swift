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
    
    @IBOutlet weak var dashedCircleView: DashedCircleView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectedDaySegmentedControl: DaySelectControl!
    @IBOutlet weak var currentWeatherIconImageView: UIImageView!
    @IBOutlet weak var currentWeatherTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherCityNameLabel: UILabel!
    @IBOutlet weak var dailyHourlyForecastCollectionView: UICollectionView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    private let locationAccessHintLabel: UILabel = {
        let locationAccessHintLabel = UILabel()
        locationAccessHintLabel.translatesAutoresizingMaskIntoConstraints = false
        locationAccessHintLabel.text = "Please, allow location access in settings"
        locationAccessHintLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return locationAccessHintLabel
    }()
    
    // MARK: Properties
    
    private var weatherForecast: WeatherForecast?
    var presenter: DailyWeatherForecastPresenterProtocol!
    
    private var isContentLoaded = false
    private var isDashedCircleViewAnimationNeedShow = true
    
    private var sunrise = Date()
    private var sunset = Date()
    private var currentTime = Date()
    private var timeZone = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationAccessHintLabel()
        setupCollectionView()
        setupRefreshControl()
        presenter.viewDidLoad()
        showProgress(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.updateWeather()
    }
    
    // MARK: UI setup
    
    private func setupLocationAccessHintLabel() {
        view.addSubview(locationAccessHintLabel)
        NSLayoutConstraint.activate([
            locationAccessHintLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationAccessHintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationAccessHintLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            locationAccessHintLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: -24)
        ])
        setLocationAccessHintHidden(false)
    }
    
    private func showProgress(_ isLoading: Bool) {
        view.subviews.forEach { $0.isHidden = isLoading }
        activityIndicatorView.isHidden = isLoading == false
        isLoading == true ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tabBarController?.tabBar.isHidden = isLoading == true
    }
    
    func setLocationAccessHintHidden(_ isHidden: Bool) {
        locationAccessHintLabel.isHidden = isHidden
    }
    
    private func setupRefreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(updateWeather), for: .valueChanged)
    }
    
    private func setupCollectionView() {
        let flowLayout = dailyHourlyForecastCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        flowLayout.minimumLineSpacing = 48
    }
    
    @objc private func updateWeather() {
        presenter.updateWeather()
    }
    
   private func isDashedCircleViewVisible(view: UIView) -> Bool {
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
    
    private func checkIfTimeInRange(_ currentTime: Date) -> Bool {
        return currentTime >= self.sunrise && currentTime <= self.sunset
    }
    
    private func updateDaySegmentedControl(items: [[TemperatureInfo]]) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        
        var dateItems: [String] = []
        
        for (index, date) in items.enumerated() {
            if index == 0 || index == 1 || index == 2 {
                let date = Date(timeIntervalSince1970: TimeInterval(date[0].time))
                let item = dateFormatter.string(from: date)
                dateItems.append(item)
            }
        }
        
        self.selectedDaySegmentedControl.items = dateItems
    }
}

// MARK: DailyWeatherForecastViewProtocol conformation

extension DailyWeatherForecastViewController: DailyWeatherForecastViewProtocol {
    
    func showLocationError(_ error: String) {
        activityIndicatorView.stopAnimating()
        self.showToast(message: error, font: .systemFont(ofSize: 14))
        self.setLocationAccessHintHidden(false)
        self.activityIndicatorView.isHidden = true
        
        if (error == "The operation couldn’t be completed. (kCLErrorDomain error 0.)") {
            presenter.viewDidLoad()
        }
    }
    
    func showCurrentWeather(with currentWeather: WeatherForecast) {
        
        showProgress(false)
        
        guard let refreshControl = scrollView.refreshControl else { return }
        refreshControl.endRefreshing()
        
        locationAccessHintLabel.isHidden = true
        
        self.weatherForecast = currentWeather
        self.currentWeatherIconImageView.image = currentWeather.weatherIcon
        self.currentWeatherTemperatureLabel.text = currentWeather.getTemperature()
        self.currentWeatherCityNameLabel.text = currentWeather.cityName
        self.windLabel.text = currentWeather.getWindSpeed()
        self.humidityLabel.text = currentWeather.getHumidity()
        self.pressureLabel.text = currentWeather.getPressure()
        self.windDirectionLabel.text = currentWeather.getWindDegree()
        self.updateDaySegmentedControl(items: currentWeather.futureDays.chunked(into: 3))
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
        
        return CGSize(width: width,
                      height: dailyHourlyForecastCollectionView.bounds.size.height * 0.7)
    }
}

// MARK: UICollectionViewDelegate

extension DailyWeatherForecastViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.scrollView === scrollView
            else {
                let offSet = scrollView.contentOffset.x
                let width = scrollView.frame.width
                let horizontalCenter = width / 2

                selectedDaySegmentedControl.selectedIndex = Int(offSet + horizontalCenter) / Int(width)
                
                return
        }
            if isDashedCircleViewVisible(view: dashedCircleView) {
                if isDashedCircleViewAnimationNeedShow {
                    
                    let currentTime = NSDate() as Date
                    let isTimeInRange = currentTime.checkIfDateInRange(start: self.sunrise,
                                                                       end: self.sunset)
                    let cur = isTimeInRange ? currentTime : self.sunset
                    
                    dashedCircleView.animate(sunrise: self.sunrise,
                                             sunset: self.sunset,
                                             currentTime: cur,
                                             timeZone: self.timeZone)
                    
                    isDashedCircleViewAnimationNeedShow = false
                }
            } else {
                isDashedCircleViewAnimationNeedShow = true
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
