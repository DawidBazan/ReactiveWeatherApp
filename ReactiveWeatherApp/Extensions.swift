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

extension UIViewController {
	func presentErrorAlert(with message: String) {
		let title = ""
		let message = message

		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
			if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			}
		}))
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
    
    func presentLoader() {
    }
}

var loaderView: UIView?
 
extension UIViewController {
    func presentLoader(_ view: UIView) {
        let loadView = UIView.init(frame: view.bounds)
        let indicator = UIActivityIndicatorView.init(style: .large)
        indicator.startAnimating()
        indicator.center = loadView.center
        
        DispatchQueue.main.async {
            loadView.addSubview(indicator)
            view.addSubview(loadView)
        }
        loaderView = loadView
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            UIView.transition(with: self.view,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                loaderView?.removeFromSuperview()
                                loaderView = nil
            })
        }
    }
}
