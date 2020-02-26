//
//  NetworkService.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Alamofire
import Foundation

typealias WeatherResult = (Swift.Result<Data, Swift.Error>) -> Void

protocol NetworkService {
	func request(with location: UserLocation, completion: @escaping WeatherResult)
}

struct Network: NetworkService {
	func request(with location: UserLocation, completion: @escaping WeatherResult) {
		let coordinate = location.coordinate
		AF.request(ForecastRouter.getForecast(coordinate)).validate().responseJSON { response in
			switch response.result {
			case .success:
				let data = response.data
				completion(.success(data!))
			case let .failure(error):
				debugPrint(error)
				completion(.failure(WeatherError.requestFailed))
			}
		}
	}
}
