//
//  CustomSegmentedControl.swift
//  SimpleWeather
//
//  Created by Alexander on 27.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class DaySelectControl: UIControl {

    private var labels = [UILabel]()
    
    var items: [String] = ["Second Day", "Third Day", "Fourth Day"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .clear
        isUserInteractionEnabled = false
        setupLabels()
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 0 ..< items.count {
            let label = UILabel(frame: .zero)
            label.text = items[index]
            label.textAlignment = .center
            label.textColor = UIColor(named: "segmentedControlUnselectedColor")
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            self.addSubview(label)
            labels.append(label)
        }
        
        self.labels[0].textColor = UIColor(named: "segmentedContolSelectedColor")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0 ... labels.count - 1 {
            let label = labels[index]
            
            let xPos = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPos, y: 0, width: labelWidth, height: labelHeight)
        }
    }
    
    func displayNewSelectedIndex() {
        self.labels[self.selectedIndex].textColor = UIColor(named: "segmentedContolSelectedColor")
        for (index, item) in self.labels.enumerated() {
            if index != self.selectedIndex {
                item.textColor = UIColor(named: "segmentedControlUnselectedColor")
            }
        }
    }
}

