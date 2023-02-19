//
//  MainViewController.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let identifier = "Places"
    private let places = Place.getPlaces()

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
        tableView.register(
            PlaceTableViewCell.self,
            forCellReuseIdentifier: PlaceTableViewCell.identifier
        )
    }

    @objc
    private func addNewPlace() {
        let placeVC = UINavigationController(rootViewController: NewPlaceViewController())
        placeVC.modalPresentationStyle = .fullScreen
        placeVC.modalTransitionStyle = .crossDissolve
        present(placeVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell
        else { return UITableViewCell() }
        cell.set(
            name: places[indexPath.row].name,
            location: places[indexPath.row].location,
            type: places[indexPath.row].type,
            image: places[indexPath.row].placeImage!
        )
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewPlace)
         )
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
