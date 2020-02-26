//
//  WeatherDataSource.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 22/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ForecastDataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
	typealias Element = [ForecastDay]
	var forecast: [ForecastDay] = []

	func tableView(_ tableView: UITableView, observedEvent: Event<[ForecastDay]>) {
		forecast = observedEvent.element ?? []

		UIView.transition(with: tableView,
		                  duration: 0.5,
		                  options: .transitionCrossDissolve,
		                  animations: { tableView.reloadData() })
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
		if indexPath == IndexPath(row: 0, section: 0) {
			cell.timeLbl.text = "Now"
		}

		return cell
	}
}
