//
//  CurrentWeatherViewModel.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ForecastViewModel {
	private let reachabilityChecker: ReachabilityChecker
	private let locationFetcher: LocationFetcher
	private let weatherFetcher: WeatherFetcher

    var isLoading: Observable<Bool>
	var errorMessage: Observable<String>
	private var location: UserLocation?
	private let forecast = BehaviorRelay<[ForecastDay]>(value: [])
    private let loaderSubject = PublishSubject<Bool>()
	private let errorSubject = PublishSubject<String>()
	private let disposeBag = DisposeBag()

	init(reachability: ReachabilityChecker, location: LocationFetcher, weather: WeatherFetcher) {
		reachabilityChecker = reachability
		locationFetcher = location
		weatherFetcher = weather
        isLoading = loaderSubject.asObserver()
		errorMessage = errorSubject.asObserver()
	}

	private func updateWeather() {
		reachabilityChecker.updateWhenReachable()
			.flatMap { _ in self.locationFetcher.fetch() }
			.flatMap { self.weatherFetcher.fetch(for: $0) }
			.subscribe(onNext: { [weak self] state in
				switch state {
				case .loading:
                    self?.loaderSubject.onNext(true)
				case let .loaded(weather):
                    self?.loaderSubject.onNext(false)
					self?.location = weather.location
					self?.forecast.accept(weather.forecastDays)
				}
			}, onError: { [weak self] error in
				guard let err = error as? WeatherError else {
					self?.errorSubject.onNext("\(error)")
					return
				}
				self?.errorSubject.onNext(err.message())
			}).disposed(by: disposeBag)
	}

	func setupTableView(_ tableView: UITableView) {
		tableView.tableFooterView = UIView()

		tableView.rowHeight = 70
		tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.cellId)

		forecast.asObservable()
			.skip(1)
			.bind(to: tableView.rx.items(dataSource: ForecastDataSource()))
			.disposed(by: disposeBag)
		updateWeather()
	}

	func createDetailedVC(for index: IndexPath) -> DetailedWeatherVC {
		let details = forecast.value[index.section].weather[index.row]
		let detailedViewModel = DetailedWeatherViewModel(details: details, location: location)
		let vc = DetailedWeatherVC()
		vc.viewModel = detailedViewModel
		return vc
	}
}
