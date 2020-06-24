//
//  CardCell.swift
//  SimpleWeather
//
//  Created by Alexander on 27.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

enum CardType: CaseIterable {
    case day
    case evening
    case night
}

extension DayCardCell {
    func getPath(for cardType: CardType) -> UIBezierPath {
        switch cardType {
        case .day:
            return UIBezierPath(roundedRect: CGRect(x: 0,
                                                    y: bounds.height * 0.5,
                                                    width: bounds.width * 2,
                                                    height: bounds.height),
                                byRoundingCorners: [.topLeft],
                                cornerRadii: CGSize(width: bounds.width * 0.4, height: 0))
        case .evening:
            return UIBezierPath(rect: CGRect(x: 0, y: self.bounds.height / 2, width: self.bounds.width, height: self.bounds.height / 2))
        case .night:
            return UIBezierPath(roundedRect: CGRect(x: 0,
                                                    y: 0,
                                                    width: bounds.width,
                                                    height: bounds.height * 0.5),
                                byRoundingCorners: [.bottomRight],
                                cornerRadii: CGSize(width: bounds.width * 0.4, height: 0))
        }
    }
    
    func getBackGroundColor(for cardType: CardType) -> UIColor {
        switch cardType {
        case .day:
            return UIColor(named: "dayCardFirstDayBackgroundColor")!
        case .evening:
            return UIColor(named: "dayCardSecondDayBackgroundColor")!
        case .night:
            return UIColor(named: "dayCardThirdDayBackgroundColor")!
        }
    }
    
    func getPathColor(for: CardType) -> UIColor {
        switch cardType {
        case .day:
            return UIColor(named: "dayCardFirstDayPathColor")!
        case .evening:
            return UIColor(named: "dayCardSecondDayPathColor")!
        case .night:
            return UIColor(named: "dayCardThirdDayPathColor")!
        }
    }
}

class DayCardCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var cardType: CardType = .day
    let shapeLayer = CAShapeLayer()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 12
        layer.insertSublayer(shapeLayer, at: 0)
        clipsToBounds = true
    }
    
    func bind(_ weather: TemperatureInfo, cardType: CardType) {
        
        self.cardType = cardType
        
        backgroundColor = getBackGroundColor(for: self.cardType)
        self.timeLabel.text = configureDate(for: weather.time)
        let number = Double(weather.temperature)
        self.temperatureLabel.text = "\(String(format: "%.0f", number))°"
        self.iconImageView.image = weather.weatherIcon
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shapeLayer.path = getPath(for: self.cardType).cgPath
        shapeLayer.fillColor = getPathColor(for: self.cardType).cgColor
        CATransaction.commit()
        
        setNeedsLayout()
    }
    
    private func configureDate(for time: Int) -> String? {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0000)!
        
        let formattedString = dateFormatter.string(from: date as Date)
        
        return formattedString
    }
}
