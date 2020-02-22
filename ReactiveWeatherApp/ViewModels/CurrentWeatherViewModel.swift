//
//  CurrentWeatherViewModel.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CurrentWeatherViewModel {
    private let locationFetcher: LocationFetcher
    private let weatherFetcher: WeatherFetcher
    
    var userLocation: Observable<UserLocation>?
    var forecast: Observable<[ForecastDay]>
    private let _forecast = BehaviorRelay<[ForecastDay]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(location: LocationFetcher, weather: WeatherFetcher) {
        self.locationFetcher = location
        self.weatherFetcher = weather
        self.forecast = _forecast.asObservable()
    }
    
    func updateWeather() {
        locationFetcher.fetch()
            .flatMap { self.weatherFetcher.fetch(for: $0) }
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .loading:
                    print("Loading!")
                case .loaded(let weather):
                    self?._forecast.accept(weather.forecastDays)
                }
            }).disposed(by: disposeBag)
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.cellId)
    
        forecast
            .skip(1)
            .bind(to: tableView.rx.items(dataSource: ForecastDataSource()))
            .disposed(by: disposeBag)
        self.updateWeather()
    }
}
