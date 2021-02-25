//
//  IndicatorView.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/24.
//

import UIKit

class IndicatorView: UIVisualEffectView {
    private var shapeLayer: CAShapeLayer?
    private let animatorGroup = CAAnimationGroup()
    convenience init(_ style: UIBlurEffect.Style) {
        self.init(effect: UIBlurEffect(style: style))
    }
    private override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        config()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(arcCenter: .init(x: rect.midX, y: rect.midY), radius: (rect.width - 80)/2, startAngle: CGFloat(Double.pi * 3/2), endAngle: CGFloat(Double.pi * 7/2), clockwise: true)
        shapeLayer?.path = path.cgPath
        shapeLayer?.add(animatorGroup, forKey: "animationGroupForPath")
    }
    private func config() {
        self.alpha = 0.6
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.gray.cgColor
        shape.lineWidth = 6
        layer.addSublayer(shape)
        layer.cornerRadius = 20
        self.shapeLayer = shape
        clipsToBounds = true

        let animatorEnd = CABasicAnimation(keyPath: "strokeEnd")
        animatorEnd.fromValue = 0
        animatorEnd.toValue = 1
        animatorEnd.duration = 1.2
        animatorEnd.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animatorStart = CABasicAnimation(keyPath: "strokeStart")
        animatorStart.fromValue = 0
        animatorStart.toValue = 1
        animatorStart.duration = 1.2
        animatorStart.beginTime = 1.2
        animatorStart.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        animatorGroup.animations = [animatorEnd, animatorStart]
        animatorGroup.fillMode = .forwards
        animatorGroup.duration = 2.4
        animatorGroup.repeatCount = .infinity
    }
}
