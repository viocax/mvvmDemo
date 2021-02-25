//
//  ViewModel.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/23.
//

import RxCocoa
import RxSwift

class ViewModel {
    struct Input {
        let trigger: Driver<Void>
    }
    struct Output {
        let item: Driver<[String]>
    }
    func transform(_ input: Input) -> Output {
        typealias ViewDataType = SharedSequence<DriverSharingStrategy, [String]>
        let item = input.trigger.flatMapLatest { _ -> ViewDataType in
            let fakeData = (0...10).map(String.init)
            return Driver.just(fakeData)
        }
        return Output(item: item)
    }
}
