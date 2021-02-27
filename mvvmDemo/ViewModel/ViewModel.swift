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
        let hudTracker = Tracker()
        let apiRequest = Service
            .request()
            .tracking(hudTracker)
        let item = input
            .trigger
            .flatMapLatest(apiRequest.asDriverOnErrorJustReturn)
            .map { $0.info.shuffled() }
        return Output(item: item, isLoading: hudTracker.asDriver())
    }
}
