//
//  Extensions.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 19/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0, enableInsets: Bool = false) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)

        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
        }

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop + topInset).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom - bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func anchorSize(width: CGFloat, height: CGFloat) {
        if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func pinCenter(to view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func pinEdges(to view: UIView, padding: CGFloat = 0) {
        
        let layout = view.safeAreaLayoutGuide
        
        leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -padding).isActive = true
        topAnchor.constraint(equalTo: layout.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: layout.bottomAnchor).isActive = true
    }
}
