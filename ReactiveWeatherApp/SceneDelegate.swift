//
//  SceneDelegate.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Swinject
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	let container: Container = {
		let container = Container()

		// Services
		container.register(ReachabilityService.self) { _ in Reachability() }
		container.register(ReachabilityChecker.self) { r in
			ReachabilityChecker(reachability: r.resolve(ReachabilityService.self)!)
		}
		container.register(LocationService.self) { _ in Location() }
		container.register(LocationFetcher.self) { r in
			LocationFetcher(location: r.resolve(LocationService.self)!)
		}
		container.register(NetworkService.self) { _ in Network() }
		container.register(WeatherFetcher.self) { r in
			WeatherFetcher(network: r.resolve(NetworkService.self)!)
		}

		// ViewModels
		container.register(ForecastViewModel.self) { r in
			let viewModel = ForecastViewModel(reachability: r.resolve(ReachabilityChecker.self)!,
			                                  location: r.resolve(LocationFetcher.self)!,
			                                  weather: r.resolve(WeatherFetcher.self)!)
			return viewModel
		}

		// ViewControllers
		container.register(ForecastVC.self) { r in
			let controller = ForecastVC()
			controller.viewModel = r.resolve(ForecastViewModel.self)
			return controller
		}
		return container
	}()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = UINavigationController(rootViewController: container.resolve(ForecastVC.self)!)
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
}
