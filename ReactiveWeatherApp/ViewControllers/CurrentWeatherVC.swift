//
//  ViewController.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit

class CurrentWeatherVC: UIViewController {
    
    let weatherImageView = UIImageView()
    let locationLbl = UILabel()
    let descriptionLbl = UILabel()
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    var viewModel: CurrentWeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Weather 🌤"
        self.setupLayout()
        self.setupView()
    }

    private func setupLayout() {
        locationLbl.font = UIFont.boldSystemFont(ofSize: 25)
        locationLbl.textColor = .orange
        locationLbl.text = "Hello World"
        descriptionLbl.font = UIFont.boldSystemFont(ofSize: 25)
        descriptionLbl.textColor = .orange
        descriptionLbl.text = "description"
        
        let stackView = UIStackView(arrangedSubviews: [tableView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        self.view.addSubview(stackView)
        
        //constraints
        stackView.fillSuperview()
    }
    
    private func setupView() {
        self.viewModel.setupTableView(tableView)
    }
}
