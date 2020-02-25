//
//  ErrorModel.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 17/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case unreachable
    case placemarkNil
    case locationFailed
    case requestFailed
    case decodeFailed
}

extension WeatherError {
    func message() -> String {
        switch self {
        case .unreachable:
            return "Network is unreachable \nPlease make sure you have access to the internet"
        case .placemarkNil:
            return "Location error \nPlease make sure you have granted access to your location."
        case .locationFailed:
            return "Location error \nPlease make sure you have granted access to your location."
        case .requestFailed:
            return "Request failed \nPlease try again."
        case .decodeFailed:
            return "Decode failed \nPlease try again."
        }
    }
}
