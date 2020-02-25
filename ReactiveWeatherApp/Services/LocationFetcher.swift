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
    
    func fetch() -> Observable<UserLocation> {
        return Observable.create { observer in
            self.location.fetchLocation { result in
                switch result {
                case .success(let location):
                    self.getUserLocation(from: location) { locResult in
                        switch locResult {
                        case .success(let userLocation):
                            observer.onNext(userLocation)
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
                case .failure(let error):
                    debugPrint(error)
                    observer.onError(WeatherError.locationFailed)
                }
            }
            return Disposables.create()
        }
    }
    
    typealias LocationResult = Result<UserLocation, WeatherError>

    private func getUserLocation(from location: CLLocation, completion: @escaping (LocationResult) -> Void) {
        var currentLocation: UserLocation!
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            guard let placemark = placemarks?[0] else {
                print("Error in \(#function): placemark is nil")
                completion(.failure(.placemarkNil))
                return
            }
            guard let city = placemark.locality, let country = placemark.country else {
                print("Error in \(#function): city or country is nil")
                completion(.failure(.locationFailed))
                return
            }
            currentLocation = UserLocation(city: city, country: country, coordinate: location.coordinate)
            completion(.success(currentLocation))
        }
    }
}
