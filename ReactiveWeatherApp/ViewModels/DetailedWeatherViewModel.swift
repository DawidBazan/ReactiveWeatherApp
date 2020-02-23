//
//  DetailedWeatherViewModel.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 22/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation

class DetailedWeatherViewModel {
    
    private let weatherDetails: WeatherData
    private let location: UserLocation?
    
    init(details: WeatherData, location: UserLocation?) {
        self.weatherDetails = details
        self.location = location
    }
    
    func getDetails() -> String {
        let details = weatherDetails.description
        return "☁️ \(details)"
    }
    
    func getTemperature() -> String {
        let temp = UnitFormatter.temperature(weatherDetails.temperature, as: .celsius)
        return "🌡 \(temp)"
    }
    
    func getWind() -> String {
        let wind = UnitFormatter.speed(weatherDetails.wind.speed, as: .kilometersPerHour)
        return "💨 \(wind)"
    }
    
    func getWindDirecion() -> String {
        let direction = UnitFormatter.windDirection(from: weatherDetails.wind.deg)
        return "🧭 \(direction)"
    }
    
    func getPressure() -> String {
        let pressure = UnitFormatter.pressure(from: weatherDetails.info.pressure)
        return "🍾 \(pressure)"
    }
    
    func getHumidity() -> String {
        let humidity = UnitFormatter.percentage(from: weatherDetails.info.humidity)
        return "☔️ \(humidity)"
    }
    
    func getLocation() -> UserLocation? {
        return location
    }
}
