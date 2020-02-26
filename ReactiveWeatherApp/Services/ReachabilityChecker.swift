//
//  ReachabilityChecker.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 25/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import RxSwift

struct ReachabilityChecker {
    let reachability: ReachabilityService
    
    func isReachable() -> Bool {
        return reachability.isReachable()
    }

    func updateWhenReachable() -> Observable<Bool> {
        return Observable.create { observer in
            self.reachability.reachabilityObserver { result in
                switch result {
                case .success:
                    observer.onNext(true)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
