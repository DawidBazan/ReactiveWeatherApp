//
//  ViewController.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit
import Layoutless

class CurrentWeatherVC: UIViewController {
    
    let weatherImageView = UIImageView()
    let locationLbl = UILabel(style: StyleSheet.location)
    let descriptionLbl = UILabel(style: StyleSheet.description)
    let tableView = UITableView(style: StyleSheet.tableView)
    
    var viewModel: CurrentWeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupLayout()
        self.setupView()
    }

    private func setupLayout() {
        let layout = stack(.vertical, spacing: 15)(
            weatherImageView,
            locationLbl,
            descriptionLbl,
            tableView
        ).fillingParent(insets: 15, relativeToSafeArea: true)
        layout.layout(in: self.view)
    }
    
    private func setupView() {
        self.viewModel.setupTableView(tableView)
    }
}

extension CurrentWeatherVC {
    
    private enum StyleSheet {
        static let image = Style<UIImageView> {
            $0.contentMode = .scaleAspectFit
            $0.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        }
        
        static let location = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
            $0.text = "Poland"
            $0.textAlignment = .center
        }
        
        static let description = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.text = "Sunny"
        }
        
        static let tableView = Style<UITableView> {
            $0.backgroundView = UIView()
            $0.backgroundColor = .systemBackground
        }
    }
}
