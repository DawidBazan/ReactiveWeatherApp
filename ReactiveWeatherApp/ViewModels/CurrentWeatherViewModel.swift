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
    
    var currentWeather: Observable<[WeatherData]>
    private let currentWeatherBehaviorRelay = BehaviorRelay<[WeatherData]>(value: [])
    
    let disposeBag = DisposeBag()
    
    init() {
        currentWeather = currentWeatherBehaviorRelay.asObservable()
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.cellId)
        
        var testData: [WeatherData] = []
        
        for _ in 0...10 {
            let info = Info(temp: 23, pressure: 20, humidity: 1)
            let wind = Wind(speed: 20, deg: 20)
            let data = WeatherData(time: "10", temperature: 23, description: "test", info: info, wind: wind, precipitation: nil)
            testData.append(data)
        }
    
        currentWeather.bind(to: tableView.rx.items(cellIdentifier: WeatherCell.cellId, cellType: WeatherCell.self)) { _, weather, cell in
                cell.setupView(with: weather)
                }.disposed(by: disposeBag)
            
        currentWeatherBehaviorRelay.accept(testData)
    }
}
