//
//  Observable+Operation.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/23.
//

import class UIKit.UIViewController
import RxSwift
import RxCocoa

// MARK: - ObservableType
extension ObservableType {
    // MARK: Just for unwrapped Observable Type easily
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

    func asDriverOnErrorJustReturn() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}

// MARK: - Reactive
extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
    var viewWillDisAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillDisappear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidAppear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
    var viewDidDisAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidDisappear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
}
