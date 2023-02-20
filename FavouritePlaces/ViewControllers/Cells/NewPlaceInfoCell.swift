//
//  NewPlaceInfoCell.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 15.02.2023.
//

import UIKit

class NewPlaceInfoCell: UITableViewCell {
    static let identifier = "NewPlaceInfoCell"
    private var barButtonDelegate: UIBarButtonItem!

    private lazy var describingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .thin)
        return label
    }()

    private lazy var describeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.autocorrectionType = .yes
        textField.contentVerticalAlignment = .bottom
        textField.returnKeyType = .done
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        describeTextField.delegate = self
        describeTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(labelName: String, textFieldName: String, delegate: UIBarButtonItem?) {
        describeLabel.text = labelName
        describeTextField.placeholder = textFieldName
        barButtonDelegate = delegate
    }

    @objc
    func textFieldChanged() {
        if describeTextField.text?.isEmpty == false {
            barButtonDelegate?.isEnabled = true
        } else {
            barButtonDelegate?.isEnabled = false
        }
    }
}

extension NewPlaceInfoCell {
    private func setSubviews(forStack stackview: UIStackView, _ subviews: UIView...) {
        subviews.forEach { stackview.addArrangedSubview($0) }
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func setupUI() {
        self.selectionStyle = .none
        setSubviews(describingStackView)
        setSubviews(forStack: describingStackView, describeLabel, describeTextField)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            describingStackView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 8),
            describingStackView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 16),
            describingStackView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            describingStackView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}

extension NewPlaceInfoCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
