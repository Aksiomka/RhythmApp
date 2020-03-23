//
//  ProgressView.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 20/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class ProgressView: UIView {
    
    private var arcLayer: CAShapeLayer?
    
    func startAnimation(percentage: Int, duration: TimeInterval) {
        let layerAnimation = CABasicAnimation(keyPath: "strokeEnd")
        layerAnimation.fromValue = arcLayer!.strokeEnd
        layerAnimation.toValue = 1
        layerAnimation.duration = duration
        layerAnimation.isRemovedOnCompletion = true
        layerAnimation.repeatCount = 1
        layerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        arcLayer!.removeAllAnimations()
        arcLayer!.add(layerAnimation, forKey: "growingAnimation")
    }
    
    private func getStrokeEndByPercentage(percentage: Int) -> CGFloat {
        return CGFloat(CGFloat(percentage) / 100.0)
    }
    
    func stopAnimation(percentage: Int) {
        arcLayer!.removeAllAnimations()
        arcLayer!.strokeEnd = getStrokeEndByPercentage(percentage: percentage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createLayers()
    }
    
    private func createLayers() {
        let rect = frame
        
        let center: CGPoint = CGPoint(x: rect.midX, y: rect.midY)
        let radius: CGFloat = rect.width / 2 - 2
        
        let (startAngle, endAngle) = getStartAndEndAnglesInRadians(percentage: 100)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        _ = createLayer(color: UIColor.lightGray, path: path, strokeEnd: 1)
        
        self.arcLayer = createLayer(color: UIColor.white, path: path, strokeEnd: 0)
    }
    
    private func createLayer(color: UIColor, path: UIBezierPath, strokeEnd: CGFloat) -> CAShapeLayer {
        let arcLayer = CAShapeLayer()
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.strokeColor = color.cgColor
        arcLayer.strokeEnd = strokeEnd
        arcLayer.lineWidth = 3
        arcLayer.path = path.cgPath
        arcLayer.frame = self.bounds
        self.layer.addSublayer(arcLayer)
        return arcLayer
    }
    
    private func getStartAndEndAnglesInRadians(percentage: CGFloat) -> (startAngle: CGFloat, endAngle: CGFloat) {
        // we take 25% off the starting point, so that a zero starting point
        // begins at the top of the circle instead of the right side...
        let startPosition: CGFloat = -25

        // we calculate a true fill percentage as we need to account
        // for the potential difference in starting points
        let trueFillPercentage = percentage + startPosition

        // now we can calculate our start and end points in radians
        let startPoint: CGFloat = ((2 * .pi) / 100) * startPosition
        let endPoint: CGFloat = ((2 * .pi) / 100) * (CGFloat(trueFillPercentage))

        return (startPoint, endPoint)
    }
    
}
