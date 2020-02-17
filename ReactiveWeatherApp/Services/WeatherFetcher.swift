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

  
    private func decodeData(_ data: Data) -> Weather? {
        guard let decodedWeather = try? JSONDecoder().decode(Weather.self, from: data) else {
            return nil
        }
        return decodedWeather
    }
}
