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
    var movingCircleSunBeams = CAShapeLayer()
    
    var horizonLine = CAShapeLayer()
 
    func createHorizonLine() {
        //design the path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: bounds.size.height / 2 + 25))
        path.addLine(to: CGPoint(x: bounds.maxX - 20, y: bounds.size.height / 2 + 25))

        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        shapeLayer.lineWidth = 1.0
        layer.addSublayer(shapeLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        
        createHorizonLine()
        createStrokeFillCircleLayer()
        createStaticCircleLayer()
    }
    
    // MARK: start animation by calling this func
    
    func animate(from: Double, to: Double, cur: Double) {
        
        maskCircleLayer.removeAllAnimations()
        movingCircleLayer.removeAllAnimations()
        
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
        
        let textlayer = CATextLayer()
        textlayer.frame.size = CGSize(width: 80, height: 50)
        textlayer.frame.origin = CGPoint(x: bounds.origin.x + 20, y: bounds.size.height / 2 + 60)
        textlayer.fontSize = 20
        textlayer.alignmentMode = .center
        textlayer.string = "04:31"
        textlayer.isWrapped = true
        textlayer.borderColor = UIColor.black.cgColor
        textlayer.truncationMode = .end
        textlayer.backgroundColor = UIColor.white.cgColor
        textlayer.foregroundColor = UIColor.darkGray.cgColor
        
        let textlayer2 = CATextLayer()
        textlayer2.frame.size = CGSize(width: 80, height: 50)
        textlayer2.frame.origin = CGPoint(x: bounds.midX + max(bounds.size.height, bounds.size.width) / 4 - 10, y: bounds.size.height / 2 + 60)
        textlayer2.fontSize = 20
        textlayer2.alignmentMode = .center
        textlayer2.string = "23:31"
        textlayer2.isWrapped = true
        textlayer2.borderColor = UIColor.black.cgColor
        textlayer2.truncationMode = .end
        textlayer2.backgroundColor = UIColor.white.cgColor
        textlayer2.foregroundColor = UIColor.darkGray.cgColor

        layer.addSublayer(textlayer)
        layer.addSublayer(textlayer2)
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
               
        staticCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2 + 25),
                                        radius: max(bounds.size.height, bounds.size.width) / 3,
                                        startAngle: 0,
                                        endAngle: .pi,
                                        clockwise: false).cgPath
        layer.addSublayer(staticCircleLayer)
    }
    
    func createMaskCircleLayer(from: Double, to: Double, cur: Double) {
        maskCircleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        maskCircleLayer.lineWidth = 2.0
        maskCircleLayer.masksToBounds = false
        maskCircleLayer.strokeColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        maskCircleLayer.fillColor = UIColor.clear.cgColor
        maskCircleLayer.lineJoin = CAShapeLayerLineJoin.round
        
        maskCircleLayer.strokeStart = 0.0
        maskCircleLayer.strokeEnd = 1.0
        maskCircleLayer.mask = strokeFillCircleLayer
        
        let estimatedTime = to - from
        let beginTime = cur - from
        let percentTime = beginTime / estimatedTime
        
        let strokeEndValue: Double = (Double(1 - percentTime))
        
        let kekAnimasion = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        kekAnimasion.fromValue = 1.0
        kekAnimasion.toValue = strokeEndValue
        kekAnimasion.duration = 3
        kekAnimasion.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        kekAnimasion.fillMode = CAMediaTimingFillMode.forwards
        kekAnimasion.isRemovedOnCompletion = false
        maskCircleLayer.add(kekAnimasion, forKey: kekAnimasion.keyPath)
        
        layer.addSublayer(maskCircleLayer)
       
        maskCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2 + 25),
                                        radius: max(bounds.size.height, bounds.size.width) / 3,
                                        startAngle: 0,
                                        endAngle: .pi,
                                        clockwise: false).cgPath
    }
   
    func createMovingCircle() {
       
        let rect = CGRect(x: 0,
                          y: 0,
                          width: 20,
                          height: 20)
        let path = UIBezierPath(ovalIn: rect)
        movingCircleLayer.fillColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
        movingCircleLayer.path = path.cgPath
        movingCircleLayer.bounds = rect
        movingCircleLayer.zPosition = 1
       
        movingCircleSunBeams.path = getPathMask(size: CGSize(width: 20, height: 20), teethCount: 8, teethSize: CGSize(width: 2, height: 10), radius: 14)
        movingCircleSunBeams.fillColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
        movingCircleLayer.addSublayer(movingCircleSunBeams)
        layer.addSublayer(movingCircleLayer)
    }
   
    func rotateMovingCircle(from: Double, to: Double, cur: Double) {
       
        let estimatedTime = to - from
        let beginTime = cur - from
        let endAngle = beginTime / estimatedTime

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
        movingCircleSunBeams.removeAnimation(forKey: "kek")
        movingCircleSunBeams.frame = movingCircleLayer.bounds
        let anim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        anim.duration = 3
        anim.toValue = CATransform3DRotate(movingCircleSunBeams.transform, CGFloat(Double.pi), 0.0, 0.0, 1.0)
        anim.repeatCount = .infinity
        movingCircleSunBeams.add(anim, forKey: "kek")
    }
}
 

