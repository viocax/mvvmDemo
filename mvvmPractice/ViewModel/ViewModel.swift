//
//  ViewModel.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/23.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModel {
    struct Input {
        let trigger: Driver<Void>
    }
    struct Output {
        let item: Driver<[Info]>
        let isLoading: Driver<Bool>
    }
    func transform(_ input: Input) -> Output {
        let checkLoading = PublishRelay<Bool>()
        func stopLoading() {
            checkLoading.accept(false)
        }
        func startLoading() {
            checkLoading.accept(true)
        }
        let hudTracker = checkLoading
            .asDriverOnErrorJustReturn()
            .distinctUntilChanged()
        let apiRequest = Service
            .request()
            .do(onNext: { _ in
                stopLoading()
            }, onError: { error in
                stopLoading()
            }, onCompleted: {
                stopLoading()
            }, onSubscribe: {
                startLoading()
            })
        let item = input
            .trigger
            .flatMapLatest(apiRequest.asDriverOnErrorJustReturn)
            .map { $0.info.shuffled() }
        return Output(item: item, isLoading: hudTracker)
    }
}
