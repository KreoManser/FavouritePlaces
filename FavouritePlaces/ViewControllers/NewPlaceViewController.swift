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
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewPlacePhotoCell.self, forCellReuseIdentifier: NewPlacePhotoCell.identifier)
        tableView.register(NewPlaceInfoCell.self, forCellReuseIdentifier: NewPlaceInfoCell.identifier)
    }

    @objc
    private func close() {
        dismiss(animated: true)
    }

    @objc
    private func save() {

    }
}

extension NewPlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewPlacePhotoCell.identifier, for: indexPath) as? NewPlacePhotoCell
                else { return UITableViewCell() }
                return cell
            case 1:
                guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewPlaceInfoCell.identifier, for: indexPath) as? NewPlaceInfoCell
                else { return UITableViewCell() }
                cell.set(labelName: "Name", textFieldName: "Place name")
                
                return cell
            case 2:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewPlaceInfoCell.identifier, for: indexPath) as? NewPlaceInfoCell
                else { return UITableViewCell() }
                cell.set(labelName: "Location", textFieldName: "Location name")
                return cell
            case 3:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewPlaceInfoCell.identifier, for: indexPath) as? NewPlaceInfoCell
                else { return UITableViewCell() }
                cell.set(labelName: "Type", textFieldName: "Type name")
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "def", for: indexPath)
                return cell
        }
    }
}

extension NewPlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 250
            default:
                return 75
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

        } else {
            view.endEditing(true)
        }
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(close)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save)
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

