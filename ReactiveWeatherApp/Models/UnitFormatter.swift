//
//  UnitFormatter.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 22/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation

enum UnitFormatter {
    static func temperature(_ value: Double, as unit: UnitTemperature) -> String {
        let formatter = MeasurementFormatter()
        let temp = Measurement(value: value, unit: unit)
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        return formatter.string(from: temp)
    }

    static func temperatureConvert(_ value: Double, from unit1: UnitTemperature, to unit2: UnitTemperature) -> String {
        let formatter = MeasurementFormatter()
        let convertedTemp = Measurement(value: value, unit: unit1).converted(to: unit2)
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        return formatter.string(from: convertedTemp)
    }

    static func speed(_ value: Double, as unit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        let speed = Measurement(value: value, unit: unit)
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        return formatter.string(from: speed)
    }
    
    static func speedConvert(_ value: Double, from unit1: UnitSpeed, to unit2: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        let speed = Measurement(value: value, unit: unit1).converted(to: unit2)
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        return formatter.string(from: speed)
    }

    static func percentage(from value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1
        let finalValue = formatter.string(from: value as NSNumber)!
        return finalValue
    }

    static func millimeters(from value: Double) -> String {
        let formatter = MeasurementFormatter()
        let millimeters = Measurement(value: value, unit: UnitLength.millimeters)
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.unitOptions = .providedUnit
        return formatter.string(from: millimeters)
    }

    static func pressure(from value: Double) -> String {
        let pressure = "\(Int(value.rounded())) hPa"
        return pressure
    }

    static func windDirection(from value: Double) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((value / 45).rounded()) % 8
        return directions[index]
    }
}
