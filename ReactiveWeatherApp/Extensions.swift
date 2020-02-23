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
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
    
        var topInset: CGFloat = 0
        var bottomInset: CGFloat = 0
        
        if #available(iOS 11, *) {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
        }

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top + topInset).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom - bottomInset).isActive = true
        }
        if size != .zero {
            if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            }
            if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
            }
        }
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor,
               padding: padding)
    }
}
