//
//  WeatherCell.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit
import Layoutless

class WeatherCell: UITableViewCell {
    
    let weatherImageView = UIImageView()
    let descriptionLbl = UILabel(style: Stylesheet.description)
    let temperatureLbl = UILabel(style: Stylesheet.temperature)
    static let cellId = "cell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let layout = stack(.horizontal, distribution: .equalCentering)(
            weatherImageView,
            descriptionLbl,
            temperatureLbl
            ).fillingParent(insets: 15)
        layout.layout(in: self.contentView)
    }
    
    func setupView(with weather: WeatherData) {
        self.descriptionLbl.text = weather.description
        self.temperatureLbl.text = "\(weather.temperature)"
    }
}

extension WeatherCell {
    
     private struct Stylesheet {
        static let description = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textColor = .blue
        }
        static let temperature = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        }
    }
}
