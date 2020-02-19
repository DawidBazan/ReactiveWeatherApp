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
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(descriptionLbl)
        stackView.addArrangedSubview(temperatureLbl)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)
        
        //constraints
        stackView.pinEdges(to: self.contentView, padding: 15)
    }
    
    func setupView(with weather: WeatherData) {
        self.descriptionLbl.text = weather.description
        self.temperatureLbl.text = "\(weather.temperature)"
    }
}
