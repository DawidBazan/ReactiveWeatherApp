//
//  WeatherCell.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
	let timeLbl = UILabel()
	let descriptionLbl = UILabel()
	let temperatureLbl = UILabel()
	static let cellId = "cell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupLayout() {
		timeLbl.textAlignment = .left
		timeLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		descriptionLbl.textAlignment = .left
		temperatureLbl.textAlignment = .right
		temperatureLbl.font = UIFont.systemFont(ofSize: 25, weight: .medium)

		let leftStack = UIStackView(arrangedSubviews: [timeLbl, descriptionLbl])
		leftStack.axis = .vertical
		leftStack.distribution = .fill
		leftStack.alignment = .fill

		let stackView = UIStackView(arrangedSubviews: [leftStack, temperatureLbl])
		stackView.axis = .horizontal
		stackView.distribution = .equalCentering
		stackView.alignment = .fill
		addSubview(stackView)

		stackView.fillSuperview(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
	}

	func setupView(with weather: WeatherData) {
		timeLbl.text = weather.time
		descriptionLbl.text = weather.description
		temperatureLbl.text = UnitFormatter.temperature(weather.temperature, as: .celsius)
	}
}
