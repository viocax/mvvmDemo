//
//  HUDCompatible.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/25.
//

import UIKit
import RxSwift

struct Hud<Target> {
    fileprivate let target: Target
    init(_ target: Target) {
        self.target = target
    }
}

protocol HUDCompatible {
    associatedtype View
    var hud: Hud<View> { get }
}

extension UIView: HUDCompatible {
    var hud: Hud<UIView> {
        return .init(self)
    }
}

extension Hud where Target: UIView {
    func start() {
        let indicatorView: IndicatorView
        if let indicator = target.subviews.first(where: { $0 is IndicatorView }) as? IndicatorView {
           indicatorView = indicator
        } else {
            let indicator = IndicatorView()
            target.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.topAnchor.constraint(equalTo: target.topAnchor).isActive = true
            indicator.bottomAnchor.constraint(equalTo: target.bottomAnchor).isActive = true
            indicator.leadingAnchor.constraint(equalTo: target.leadingAnchor).isActive = true
            indicator.trailingAnchor.constraint(equalTo: target.trailingAnchor).isActive = true
            indicatorView = indicator
        }
        indicatorView.startAnimation()
    }
    func stop() {
        let indicator = target.subviews.first(where: { $0 is IndicatorView }) as? IndicatorView
        indicator?.stopAnimation()
        indicator?.removeFromSuperview()
    }
}

extension Reactive where Base == UIView {
    var indicatorAnimator: Binder<Bool> {
        return Binder(self.base) { (targetView, isLoading) in
            if isLoading {
                targetView.hud.start()
            } else {
                targetView.hud.stop()
            }
        }
    }
}
