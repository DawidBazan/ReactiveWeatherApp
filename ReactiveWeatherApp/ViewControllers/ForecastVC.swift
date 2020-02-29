//
//  ViewController.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import RxSwift
import UIKit

class ForecastVC: UIViewController {
	let weatherImageView = UIImageView()
	let tableView = UITableView(frame: CGRect.zero, style: .grouped)

	var viewModel: ForecastViewModel!
	let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()
		setupView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		deselectAll()
	}

	private func setupLayout() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = "Weather 🌤"
		view.addSubview(tableView)
		tableView.fillSuperview()
	}

	private func setupView() {
        viewModel.isLoading.subscribe(onNext: { isLoading in
            if isLoading {
                self.presentLoader(self.view)
            } else {
                self.removeLoader()
            }
        }).disposed(by: disposeBag)
        
		viewModel.setupTableView(tableView)
		tableView.rx.itemSelected.asDriver()
			.drive(onNext: { [weak self] indexPath in
				guard let detailedVC = self?.viewModel.createDetailedVC(for: indexPath) else { return }
				self?.navigationController?.pushViewController(detailedVC, animated: true)
			}).disposed(by: disposeBag)

		viewModel.errorMessage.subscribe(onNext: { error in
			self.presentErrorAlert(with: error)
		}).disposed(by: disposeBag)
	}

	private func deselectAll() {
		guard let index = self.tableView.indexPathForSelectedRow else { return }
		tableView.deselectRow(at: index, animated: true)
	}
}
