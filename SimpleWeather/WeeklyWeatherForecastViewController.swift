//
//  WeeklyWeatherForecastViewController.swift
//  SimpleWeather
//
//  Created by Alexander on 18.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class WeeklyWeatherForecastViewController: UIViewController {

    @IBOutlet weak var weekDaysCollectionView: UICollectionView!
    
    var weeks = ["S", "M", "T", "W", "T", "F", "S"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = weekDaysCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 0
        
        let insetsAndLineSpacing = (self.view.bounds.width - (layout.minimumLineSpacing * CGFloat(weeks.count - 1)) - (layout.sectionInset.left * 2)) / CGFloat(weeks.count)
        
        layout.itemSize = CGSize(width: insetsAndLineSpacing, height: weekDaysCollectionView.frame.height * 0.85)
        weekDaysCollectionView.isScrollEnabled = false
    }
}

extension WeeklyWeatherForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weeks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! KekCell
        cell.label.text = weeks[indexPath.item]
        return cell
    }
    
    
}

extension WeeklyWeatherForecastViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! KekCell
        cell.setHiglighted(true)
        print(collectionView.indexPathsForSelectedItems ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! KekCell
        cell.setHiglighted(false)
    }
}

class KekCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    func setHiglighted(_ isHiglighted: Bool) {
        if isHiglighted {
            self.label.textColor = UIColor(named: "SelectedDayColor")
        } else {
            self.label.textColor = UIColor(named: "UnselectedDayColor")
        }
    }
    
}
