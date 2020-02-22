//
//  WeatherDataSource.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 22/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastDataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    
    typealias Element = [ForecastDay]
    var forecast: [ForecastDay] = []
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[ForecastDay]>) {
        forecast = observedEvent.element ?? []
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecast.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forecast[section].day
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return forecast[section].weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.cellId, for: indexPath) as! WeatherCell
        let weather = forecast[indexPath.section].weather[indexPath.row]
        cell.setupView(with: weather)
        
        return cell
    }
}
