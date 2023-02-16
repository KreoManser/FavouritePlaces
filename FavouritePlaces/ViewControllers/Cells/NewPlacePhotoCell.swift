//
//  NewPlacePhotoCell.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 15.02.2023.
//
import UIKit

class NewPlacePhotoCell: UITableViewCell {
    static let identifier = "NewPlacePhotoCell"

    var imageOfPlace: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Photo")
        imageView.contentMode = .center
        //        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        //        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewPlacePhotoCell {
    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func setupUI() {
        contentView.backgroundColor = .lightGray
        
        setSubviews(imageOfPlace)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageOfPlace.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageOfPlace.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageOfPlace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageOfPlace.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
