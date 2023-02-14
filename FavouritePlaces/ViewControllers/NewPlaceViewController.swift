//
//  NewPlaceViewController.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 14.02.2023.
//

import UIKit

class NewPlaceViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
    }

    @objc
    private func close() {
        dismiss(animated: true)
    }

    @objc
    private func save() {

    }
}

extension NewPlaceViewController {
    private func setupUI() {
        setupNavigationBar()
        setSubviews(tableView)
        setConstraints()
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func setupNavigationBar() {
        navigationItem.title = "New Place"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

