//
//  Tracker.swift
//  mvvmDemo
//
//  Created by Jie liang Huang on 2021/2/27.
//

import RxCocoa
import RxSwift
import class RxRelay.PublishRelay
import class Foundation.NSRecursiveLock

final class Tracker: SharedSequenceConvertibleType {
    typealias SharingStrategy = DriverSharingStrategy
    typealias Element = Bool
    
    private let lock: NSRecursiveLock = .init()
    private let publisher: PublishRelay<Bool> = .init()
    private let loading: SharedSequence<SharingStrategy, Element>

    init() {
        loading = publisher.asDriverOnErrorJustReturn().distinctUntilChanged()
    }
    func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Bool> {
        return loading
    }
}

private extension Tracker {
    func track<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.stop()
            }, onError: {  _ in
                self.stop()
            }, onCompleted: {
                self.stop()
            }, onSubscribe: {
                self.start()
            })
    }
    func start() {
        lock.lock(); defer { lock.unlock() }
        publisher.accept(true)
    }
    func stop() {
        lock.lock(); defer { lock.unlock() }
        publisher.accept(false)
    }
}

extension ObservableConvertibleType {
    func tracking(_ tracker: Tracker) -> Observable<Element> {
        return tracker.track(self)
    }
}
