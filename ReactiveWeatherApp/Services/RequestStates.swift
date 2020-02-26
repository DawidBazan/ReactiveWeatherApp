//
//  RequestStates.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 18/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation

enum RequestState<T> {
	case loading
	case loaded(T)

	var isLoading: Bool {
		guard case .loading = self else { return false }
		return true
	}

	var data: T? {
		guard case let .loaded(t) = self else { return nil }
		return t
	}
}
