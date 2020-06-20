//
//  ViewController + Extension.swift
//  SimpleWeather
//
//  Created by Alexander on 15.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        var tabBarHeight: CGFloat = 0
        
        if let tabBar = self.tabBarController?.tabBar {
            tabBarHeight = tabBar.frame.height
        }
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - tabBarHeight - 60, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
