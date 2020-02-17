//
//  LocationFetcher.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

struct LocationFetcher {
    let location: LocationService

    private func getUserLocation(from location: CLLocation, completion: @escaping (UserLocation) -> Void) {
        var currentLocation: UserLocation!
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            guard let placemark = placemarks?[0] else {
                print("Error in \(#function): placemark is nil")
                return
            }
            guard let city = placemark.locality, let country = placemark.country else {
                print("Error in \(#function): city or country is nil")
                return
            }
            currentLocation = UserLocation(city: city, country: country, coordinate: location.coordinate)
            completion(currentLocation)
        }
    }
}
