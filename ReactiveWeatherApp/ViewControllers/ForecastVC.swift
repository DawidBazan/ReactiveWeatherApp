//
//  ViewController.swift
//  ReactiveWeatherApp
//
//  Created by Dawid on 16/02/2020.
//  Copyright © 2020 Dawid Bazan. All rights reserved.
//

import UIKit
import RxSwift

class ForecastVC: UIViewController {
    
    let weatherImageView = UIImageView()
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    var viewModel: ForecastViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.deselectAll()
    }

    private func setupLayout() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Weather 🌤"
        self.view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func setupView() {
        self.viewModel.setupTableView(tableView)
        self.tableView.rx.itemSelected.asDriver()
            .drive(onNext: { [weak self] (indexPath) in
                guard let detailedVC = self?.viewModel.createDetailedVC(for: indexPath) else { return }
                self?.navigationController?.pushViewController(detailedVC, animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func deselectAll() {
        guard let index = self.tableView.indexPathForSelectedRow else { return }
        self.tableView.deselectRow(at: index, animated: true)
    }
}
