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
    private let currentWeather = BehaviorRelay<[ForecastDay]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(location: LocationFetcher, weather: WeatherFetcher) {
        self.locationFetcher = location
        self.weatherFetcher = weather
    }
    
    func updateWeather() {
        locationFetcher.fetch()
            .flatMap { self.weatherFetcher.fetch(for: $0) }
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .loading:
                    print("Loading!")
                case .loaded(let weather):
                    self?.currentWeather.accept(weather.forecastDays)
                }
            }).disposed(by: disposeBag)
    }

    func setupTableView(_ tableView: UITableView) {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.cellId)
    
        currentWeather.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: WeatherCell.cellId, cellType: WeatherCell.self)) { index, forecast, cell in
            cell.setupView(with: forecast.weather[index])
        }.disposed(by: disposeBag)
        
        self.updateWeather()
    }
}
