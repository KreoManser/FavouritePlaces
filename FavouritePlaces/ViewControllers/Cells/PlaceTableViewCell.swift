//
//  PlaceTableViewCell.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 14.02.2023.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "CustomPlaceCell"

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var imageOfPlace: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        //        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        //        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        return label
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Type"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(name: String, location: String, type: String, image: String) {
        nameLabel.text = name
        locationLabel.text = location
        typeLabel.text = type
    }
}

extension PlaceTableViewCell {
    private func setSubviews(forStack stackview: UIStackView, _ subviews: UIView...) {
        subviews.forEach { stackview.addArrangedSubview($0) }
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func setupUI() {
        setSubviews(imageOfPlace, infoStackView)
        setSubviews(forStack: infoStackView, nameLabel, locationLabel, typeLabel)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageOfPlace.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 10),
            imageOfPlace.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageOfPlace.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageOfPlace.heightAnchor
                .constraint(equalToConstant: 65),
            imageOfPlace.widthAnchor
                .constraint(equalToConstant: 65),

            infoStackView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 8),
            infoStackView.leadingAnchor
                .constraint(equalTo: imageOfPlace.trailingAnchor, constant: 16),
            infoStackView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -8),

//            nameLabel.topAnchor
//                .constraint(equalTo: contentView.topAnchor, constant: 9),
//            nameLabel.leadingAnchor
//                .constraint(equalTo: imageOfPlace.trailingAnchor, constant: 15),
//            nameLabel.trailingAnchor
//                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
//
//            typeLabel.leadingAnchor
//                .constraint(equalTo: imageOfPlace.trailingAnchor, constant: 15),
//            typeLabel.trailingAnchor
//                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            typeLabel.bottomAnchor
//                .constraint(equalTo: contentView.bottomAnchor, constant: -9.5),
//
//            locationLabel.topAnchor
//                .constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
//            locationLabel.leadingAnchor
//                .constraint(equalTo: imageOfPlace.trailingAnchor, constant: 15),
//            locationLabel.trailingAnchor
//                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            locationLabel.bottomAnchor.constraint(equalTo: typeLabel.topAnchor, constant: 1),
        ])
    }
}
