//
//  WeatherFetcher.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import RxSwift

struct WeatherFetcher {
	let network: NetworkService

	func fetch(for location: UserLocation) -> Observable<RequestState<Weather>> {
		return Observable.create { observer in
			observer.onNext(.loading)
			self.network.request(with: location) { result in
				switch result {
				case let .success(data):
					guard var weather = self.decodeData(data) else {
						observer.onError(WeatherError.decodeFailed)
						return
					}
					weather.location = location
					observer.onNext(.loaded(weather))
				case let .failure(error):
					observer.onError(error)
				}
			}
			return Disposables.create()
		}
	}

	private func decodeData(_ data: Data) -> Weather? {
		guard let decodedWeather = try? JSONDecoder().decode(Weather.self, from: data) else {
			return nil
		}
		return decodedWeather
	}
}
