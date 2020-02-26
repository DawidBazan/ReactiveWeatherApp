//
//  WeatherModel.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation

struct Weather: Codable {
	private let forecast: [Forecast]
	let forecastDays: [ForecastDay]
	var location: UserLocation?

	enum CodingKeys: String, CodingKey {
		case forecast = "list"
		case forecastDays
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		forecast = try container.decode([Forecast].self, forKey: .forecast)
		forecastDays = sortForecastByDay(forecast)
	}
}

private struct Forecast: Codable {
	let date: String
	let info: Info
	let wind: Wind
	let precipitation: Precipitation?
	let details: [Details]

	enum CodingKeys: String, CodingKey {
		case date = "dt_txt"
		case info = "main"
		case wind
		case precipitation = "rain"
		case details = "weather"
	}
}

private struct Details: Codable {
	let description: String
}

struct Info: Codable {
	let temp: Double
	let pressure: Double
	let humidity: Int
}

struct Wind: Codable {
	let speed: Double
	let deg: Double
}

struct Precipitation: Codable {
	let value: Double?

	enum CodingKeys: String, CodingKey {
		case value = "3h"
	}
}

// MARK: Custom codable

struct ForecastDay: Codable {
	let day: String
	var weather: [WeatherData]
}

struct WeatherData: Codable {
	let time: String
	let temperature: Double
	let description: String
	let info: Info
	let wind: Wind
	let precipitation: Precipitation?
}

private func sortForecastByDay(_ forecast: [Forecast]) -> [ForecastDay] {
	var forecastDays: [ForecastDay] = []

	func stringDateToDayAndTime(_ strDate: String) -> DayAndTime {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date = dateFormatter.date(from: strDate)!
		dateFormatter.dateFormat = "EEEE"

		let weatherDay = dateFormatter.string(from: date)
		dateFormatter.dateFormat = "HH:mm"

		let weatherTime = dateFormatter.string(from: date)

		let newDate = DayAndTime(day: weatherDay, time: weatherTime)

		return newDate
	}

	for forecastDay in forecast {
		let date = stringDateToDayAndTime(forecastDay.date)

		if !forecastDays.contains(where: { $0.day == date.day }) {
			forecastDays.append(ForecastDay(day: date.day, weather: []))
		}
		if let index = forecastDays.firstIndex(where: { $0.day == date.day }) {
			let temperature = forecastDay.info.temp
			let description = forecastDay.details[0].description
			let weatherInfo = forecastDay.info
			let windInfo = forecastDay.wind
			let precipitationInfo = forecastDay.precipitation

			let weather = WeatherData(time: date.time,
			                          temperature: temperature,
			                          description: description,
			                          info: weatherInfo,
			                          wind: windInfo,
			                          precipitation: precipitationInfo)

			forecastDays[index].weather.append(weather)
		}
	}
	return forecastDays
}

struct DayAndTime {
	let day: String
	let time: String
}
