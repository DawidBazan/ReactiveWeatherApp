//
//  LocationService.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import CoreLocation
import Foundation

typealias Coordinate = CLLocationCoordinate2D

protocol LocationService {
	typealias FetchLocationCompletion = (Result<CLLocation, WeatherError>) -> Void
	func fetchLocation(completion: @escaping FetchLocationCompletion)
}

class Location: NSObject, LocationService {
	private lazy var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		return locationManager
	}()

	private var didFetchLocation: FetchLocationCompletion?

	func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
		didFetchLocation = completion
		locationManager.requestLocation()
	}
}

extension Location: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		} else if status == .authorizedWhenInUse {
			locationManager.requestLocation()
		} else {
			didFetchLocation?(.failure(.locationFailed))
			didFetchLocation = nil
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		manager.stopUpdatingLocation()
		guard let location = locations.first else { return }
		didFetchLocation?(.success(location))
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}
