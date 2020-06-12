//
//  DashedCircleView.swift
//  SimpleWeather
//
//  Created by Admin on 11.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class DashedCircleView: UIView {
   
    // MARK: Layer properties
    
    var strokeFillCircleLayer = CAShapeLayer()
    var staticCircleLayer = CAShapeLayer()
    var maskCircleLayer = CAShapeLayer()
    var movingCircleLayer = CAShapeLayer()
    var movingCircleSunBeamsLayer = CAShapeLayer()
    var horizontalLineLayer = CAShapeLayer()
    var horizonLine = CAShapeLayer()
    var fromTextLayer = CATextLayer()
    var toTextLayer = CATextLayer()
 
    func createHorizonLine() {
        
        let horizontalLinePath = UIBezierPath()
        horizontalLinePath.move(to: CGPoint(x: 20, y: bounds.size.height / 2 + 25))
        horizontalLinePath.addLine(to: CGPoint(x: bounds.maxX - 20, y: bounds.size.height / 2 + 25))

        horizontalLineLayer.path = horizontalLinePath.cgPath
        horizontalLineLayer.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        horizontalLineLayer.lineWidth = 1.0
        layer.addSublayer(horizontalLineLayer)
    }
    
    func createFromToTextLayers() {
        
        fromTextLayer = CATextLayer()
        fromTextLayer.frame.size = CGSize(width: 80, height: 50)
        fromTextLayer.frame.origin = CGPoint(x: bounds.origin.x + 20, y: bounds.size.height / 2 + 60)
        fromTextLayer.fontSize = 20
        fromTextLayer.alignmentMode = .center
        fromTextLayer.string = "04:31"
        fromTextLayer.isWrapped = true
        fromTextLayer.borderColor = UIColor.black.cgColor
        fromTextLayer.truncationMode = .end
        fromTextLayer.backgroundColor = UIColor.clear.cgColor
        fromTextLayer.foregroundColor = UIColor(named: "additionalInfoValueLabelColor")?.cgColor
        
        toTextLayer = CATextLayer()
        toTextLayer.frame.size = CGSize(width: 80, height: 50)
        toTextLayer.frame.origin = CGPoint(x: bounds.midX + max(bounds.size.height, bounds.size.width) / 4 - 10, y: bounds.size.height / 2 + 60)
        toTextLayer.fontSize = 20
        toTextLayer.alignmentMode = .center
        toTextLayer.string = "23:31"
        toTextLayer.isWrapped = true
        toTextLayer.borderColor = UIColor.black.cgColor
        toTextLayer.truncationMode = .end
        toTextLayer.backgroundColor = UIColor.clear.cgColor
        toTextLayer.foregroundColor = UIColor(named: "additionalInfoValueLabelColor")?.cgColor

        layer.addSublayer(fromTextLayer)
        layer.addSublayer(toTextLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
        
        createHorizonLine()
        createFromToTextLayers()
        createStrokeFillCircleLayer()
        createStaticCircleLayer()
    }
    
    // MARK: start animation by calling this func
    
    func animate(from: Int, to: Int, cur: Int, timeZone: Int) {
        
        maskCircleLayer.removeAllAnimations()
        movingCircleLayer.removeAllAnimations()
        
        fromTextLayer.string = from.getSunriseSunsetTime(with: timeZone)
        toTextLayer.string = to.getSunriseSunsetTime(with: timeZone)
        
        self.createMovingCircle()
        self.createMaskCircleLayer(from: from, to: to, cur: cur)
        self.rotateMovingCircle(from: from, to: to, cur: cur)
        self.animateBeams()
    }
}
 
private extension DashedCircleView {
   
    private func getPathMask(size: CGSize,
                             teethCount: UInt,
                             teethSize: CGSize,
                             radius: CGFloat) -> CGPath? {
 
        let halfHeight = size.height * 0.5
        let halfWidth = size.width * 0.5
        let deltaAngle =
            CGFloat(2 * Double.pi) / CGFloat(teethCount) // The change in angle between paths
 
        // Create the template path of a single shape.
        let rect = CGRect(x: -teethSize.width * 0.5, y: radius, width: teethSize.width, height: teethSize.height)
        let p = CGPath(roundedRect: rect, cornerWidth: teethSize.height / 2, cornerHeight: teethSize.height / 2, transform: nil)
        let returnPath = CGMutablePath()
 
        for i in 0 ..< teethCount { // Copy, translate and rotate shapes around
            let translate = CGAffineTransform(translationX: halfWidth, y: halfHeight)
            let rotate = translate.rotated(by: deltaAngle * CGFloat(i))
            returnPath.addPath(p, transform: rotate)
        }
 
        return returnPath.copy()
    }
   
    func createStrokeFillCircleLayer() {
        
        strokeFillCircleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        strokeFillCircleLayer.lineWidth = 2.0
        strokeFillCircleLayer.masksToBounds = false
        strokeFillCircleLayer.strokeColor =  #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
        strokeFillCircleLayer.fillColor = UIColor.clear.cgColor
        strokeFillCircleLayer.lineJoin = CAShapeLayerLineJoin.round
        strokeFillCircleLayer.lineDashPattern = [7, 7]
        
        strokeFillCircleLayer.strokeStart = 0.0
        strokeFillCircleLayer.strokeEnd = 1.0
               
        strokeFillCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2 + 25),
                                        radius: max(bounds.size.height, bounds.size.width) / 3,
                                        startAngle: 0,
                                        endAngle: .pi,
                                        clockwise: false).cgPath
    }
    
    func createStaticCircleLayer() {
        staticCircleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        staticCircleLayer.lineWidth = 2.0
        staticCircleLayer.masksToBounds = false
        staticCircleLayer.strokeColor =  UIColor.lightGray.cgColor
        staticCircleLayer.fillColor = UIColor.clear.cgColor
        staticCircleLayer.lineJoin = CAShapeLayerLineJoin.round
        staticCircleLayer.lineDashPattern = [7, 7]
        staticCircleLayer.strokeStart = 0.0
        staticCircleLayer.strokeEnd = 1.0
        staticCircleLayer.path =
            UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2,
                                            y: bounds.size.height / 2 + 25),
                         radius: max(bounds.size.height, bounds.size.width) / 3,
                         startAngle: 0,
                         endAngle: .pi,
                         clockwise: false).cgPath
        layer.addSublayer(staticCircleLayer)
    }
    
    func createMaskCircleLayer(from: Int, to: Int, cur: Int) {
        
        maskCircleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        maskCircleLayer.lineWidth = 2.0
        maskCircleLayer.masksToBounds = false
        maskCircleLayer.strokeColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        maskCircleLayer.fillColor = UIColor.clear.cgColor
        maskCircleLayer.lineJoin = CAShapeLayerLineJoin.round
        
        maskCircleLayer.strokeStart = 0.0
        maskCircleLayer.strokeEnd = 1.0
        maskCircleLayer.mask = strokeFillCircleLayer
        
        let estimatedTime: Double = Double(to - from)
        let beginTime: Double = Double(cur - from)
        let percentTime: Double = beginTime / estimatedTime
        
        let strokeEndValue: Double = (Double(1 - percentTime))
        
        let dashedCircleStrokeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        dashedCircleStrokeAnimation.fromValue = 1.0
        dashedCircleStrokeAnimation.toValue = strokeEndValue
        dashedCircleStrokeAnimation.duration = 3
        dashedCircleStrokeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        dashedCircleStrokeAnimation.fillMode = CAMediaTimingFillMode.forwards
        dashedCircleStrokeAnimation.isRemovedOnCompletion = false
        
        maskCircleLayer.add(dashedCircleStrokeAnimation, forKey: dashedCircleStrokeAnimation.keyPath)
        maskCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2 + 25),
                                        radius: max(bounds.size.height, bounds.size.width) / 3,
                                        startAngle: 0,
                                        endAngle: .pi,
                                        clockwise: false).cgPath
        layer.addSublayer(maskCircleLayer)
    }
   
    func createMovingCircle() {
       
        let movingCircleLayerRect =
            CGRect(x: 0,
                   y: 0,
                   width: 20,
                   height: 20)
        let movingCircleLayerPath = UIBezierPath(ovalIn: movingCircleLayerRect)
        
        movingCircleLayer.fillColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
        movingCircleLayer.path = movingCircleLayerPath.cgPath
        movingCircleLayer.bounds = movingCircleLayerRect
        movingCircleLayer.zPosition = 1
        movingCircleSunBeamsLayer.path =
            getPathMask(size: CGSize(width: 20, height: 20),
                        teethCount: 8,
                        teethSize: CGSize(width: 2, height: 10),
                        radius: 14)
        movingCircleSunBeamsLayer.fillColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
        movingCircleLayer.addSublayer(movingCircleSunBeamsLayer)
        layer.addSublayer(movingCircleLayer)
    }
   
    func rotateMovingCircle(from: Int, to: Int, cur: Int) {
       
        let estimatedTime: Double = Double(to - from)
        let beginTime: Double = Double(cur - from)
        let endAngle: Double = beginTime / estimatedTime

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2 + 25),
                                      radius: max(bounds.size.height, bounds.size.width) / 3,
                                      startAngle: .pi,
                                      endAngle: CGFloat(-Double.pi * (1 - endAngle)),
                                      clockwise: true).cgPath
        
        let rotateMovingCircleAnimation = CAKeyframeAnimation(keyPath: "position")
        
        rotateMovingCircleAnimation.path = circlePath
        rotateMovingCircleAnimation.duration = 3
        rotateMovingCircleAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotateMovingCircleAnimation.isAdditive = true
        rotateMovingCircleAnimation.isRemovedOnCompletion = false
        rotateMovingCircleAnimation.repeatCount = 0
        rotateMovingCircleAnimation.calculationMode = CAAnimationCalculationMode.paced
        rotateMovingCircleAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
        rotateMovingCircleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        movingCircleLayer.add(rotateMovingCircleAnimation, forKey: "orbit")
    }
   
    func animateBeams() {
        
        movingCircleSunBeamsLayer.removeAnimation(forKey: "beamAnimation")
        movingCircleSunBeamsLayer.frame = movingCircleLayer.bounds
        
        let movingCircleSunBeamsAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        movingCircleSunBeamsAnimation.duration = 3
        movingCircleSunBeamsAnimation.toValue =
            CATransform3DRotate(movingCircleSunBeamsLayer.transform,
                                CGFloat(Double.pi),
                                0.0, 0.0, 1.0)
        movingCircleSunBeamsAnimation.repeatCount = .infinity
        
        movingCircleSunBeamsLayer.add(movingCircleSunBeamsAnimation, forKey: "beamAnimation")
    }
}
 

