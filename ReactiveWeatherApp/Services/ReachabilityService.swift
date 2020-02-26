//
//  ReachabilityService.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 25/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Alamofire
import Foundation

protocol ReachabilityService {
	typealias ReachabilityCompetion = (Swift.Result<Bool, WeatherError>) -> Void
	func isReachable() -> Bool
	func reachabilityObserver(completion: @escaping ReachabilityCompetion)
}

struct Reachability: ReachabilityService {
	let reachabilityManager = NetworkReachabilityManager()!

	func isReachable() -> Bool {
		return reachabilityManager.isReachable
	}

	func reachabilityObserver(completion: @escaping Self.ReachabilityCompetion) {
		reachabilityManager.startListening(onUpdatePerforming: { state in
			switch state {
			case .reachable:
				self.reachabilityManager.stopListening()
				completion(.success(true))
			default:
				completion(.failure(.unreachable))
			}
		})
	}
}
