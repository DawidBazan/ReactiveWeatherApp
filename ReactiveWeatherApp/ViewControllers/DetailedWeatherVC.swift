//
//  DetailedWeatherVC.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 22/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit
import MapKit

class DetailedWeatherVC: UIViewController {
    
    let mapView = MKMapView()
    let detailsLbl = UILabel()
    let temperatureLbl = UILabel()
    let windLbl = UILabel()
    let windDirectionLbl = UILabel()
    let pressureLbl = UILabel()
    let humidityLbl = UILabel()
    
    var viewModel: DetailedWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView()
    }
    
    func setupLayout() {
        self.view.backgroundColor = .systemBackground
    
        let bottomStack = bottomStackView()
        self.view.addSubview(mapView)
        self.view.addSubview(bottomStack)
        
        let navHeight = navigationController?.navigationBar.frame.height ?? 0
        let viewHight = self.view.frame.height - navHeight
        mapView.anchor(top: self.view.topAnchor,
                       leading: self.view.leadingAnchor,
                       bottom: bottomStack.topAnchor,
                       trailing: self.view.trailingAnchor,
                       padding: UIEdgeInsets(top: navHeight, left: 0, bottom: 20, right: 0),
                       size: CGSize(width: 0, height: viewHight / 2))
        
        bottomStack.anchor(top: mapView.bottomAnchor,
                           leading: self.view.leadingAnchor,
                           bottom: nil,
                           trailing: self.view.trailingAnchor,
                           padding: UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15))
    }
    
    func bottomStackView() -> UIStackView {
        let leftStack = UIStackView(arrangedSubviews: [detailsLbl, temperatureLbl, humidityLbl])
        leftStack.axis = .vertical
        leftStack.distribution = .fillEqually
        leftStack.alignment = .fill
        leftStack.spacing = 10
        
        let rightStack = UIStackView(arrangedSubviews: [windLbl, windDirectionLbl, pressureLbl])
        rightStack.axis = .vertical
        rightStack.distribution = .fillEqually
        rightStack.alignment = .fill
        rightStack.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [leftStack, rightStack])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        
        return stackView
    }
    
    func setupView() {
        if let location = viewModel.getLocation() {
            let annotation = MKPointAnnotation()
            annotation.title = "\(location.city), \(location.country)"
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
            mapView.setCenter(location.coordinate, animated: true)
        }
        
        detailsLbl.text = viewModel.getDetails()
        temperatureLbl.text = viewModel.getTemperature()
        windLbl.text = viewModel.getWind()
        windDirectionLbl.text = viewModel.getWindDirecion()
        pressureLbl.text = viewModel.getPressure()
        humidityLbl.text = viewModel.getHumidity()
    }
}
