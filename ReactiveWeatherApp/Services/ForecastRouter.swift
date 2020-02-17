//
//  Router.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import Alamofire

enum ForecastRouter: URLRequestConvertible {
    case getCurrentWeather(Coordinate)
    case getForecast(Coordinate)

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getCurrentWeather, .getForecast:
                return .get
            }
        }

        let params: ([String: Any]?) = {
            switch self {
            case let .getCurrentWeather(c), let .getForecast(c):
                return ["lat": c.latitude,
                        "lon": c.longitude,
                        "units": "metric", // imperial
                        "APPID": Constants.weatherApiKey]
            }
        }()

        let url: URL = {
            let relativePath: String?
            switch self {
            case .getCurrentWeather:
                relativePath = "data/2.5/forecast?"
            case .getForecast:
                relativePath = "data/2.5/forecast?"
            }
            var url = URL(string: Constants.baseURLString)!
            if let relativePath = relativePath {
                url = URL(string: Constants.baseURLString + relativePath)!
            }
            return url
        }()

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}
