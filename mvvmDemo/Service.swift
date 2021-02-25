//
//  Service.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/25.
//

import Foundation
import RxSwift

struct Service {
    static func request() -> Observable<InfoModel> {
        return Observable.create { (observer) -> Disposable in
            DispatchQueue.global().async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    do {
                        let model = try JSONParser.getJSON(decodeTo: InfoModel.self, fileName: "FakeDataSource")
                        observer.onNext(model)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
