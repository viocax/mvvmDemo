//
//  IndicatorView.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/24.
//

import UIKit

class IndicatorView: UIView {
    private class BlurView: UIVisualEffectView {
        private var shapeLayer: CAShapeLayer?
        private let animatorGroup = CAAnimationGroup()
        private var animationKey: String {
            return "animationGroupForPath"
        }
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
        }
        private func config() {
            isUserInteractionEnabled = true
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
        func startLoadingPath() {
            stopLoadingPath()
            shapeLayer?.add(animatorGroup, forKey: animationKey)
        }
        func stopLoadingPath() {
            shapeLayer?.removeAnimation(forKey: animationKey)
        }
    }
    private let blurView: BlurView = .init(.extraLight)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        isUserInteractionEnabled = true
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        blurView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        blurView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    public func startAnimation() {
        blurView.startLoadingPath()
    }
    public func stopAnimation() {
        blurView.stopLoadingPath()
    }
}
