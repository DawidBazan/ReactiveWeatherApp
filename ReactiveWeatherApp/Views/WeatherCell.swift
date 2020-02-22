//
//  WeatherCell.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    let weatherImageView = UIImageView()
    let descriptionLbl = UILabel()
    let temperatureLbl = UILabel()
    static let cellId = "cell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        descriptionLbl.textAlignment = .left
        temperatureLbl.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [weatherImageView, descriptionLbl, temperatureLbl])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        self.addSubview(stackView)
        
        //constraints
        stackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    func setupView(with weather: WeatherData) {
        self.descriptionLbl.text = weather.description
        self.temperatureLbl.text = "\(weather.temperature)"
    }
}
