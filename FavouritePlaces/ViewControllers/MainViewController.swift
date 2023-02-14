//
//  MainViewController.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let identifier = "Places"
    private let placesNames = [
        "Aba", "VB", "WB", "Kara", "Talka", "Loooose", "Ball"
    ]
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placesNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell
        else { return UITableViewCell() }
        cell.set(name: "AA", location: "Baumana", type: "Bar")
        cell.imageOfPlace.layer.cornerRadius = cell.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        return cell
    }


}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
}

extension MainViewController {
    private func setupUI() {
        setupNavigationBar()
        setSubviews(tableView)
        // MARK: DO THIS
        tableView.backgroundColor = .orange
        setConstraints()
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func setupNavigationBar() {
        navigationItem.title = "My Places"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "Snell Roundhand Bold", size: 24)!
        ]
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
