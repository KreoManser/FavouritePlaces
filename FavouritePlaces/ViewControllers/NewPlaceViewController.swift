//
//  NewPlaceViewController.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 14.02.2023.
//

import UIKit
import PhotosUI

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
                else { fatalError("Doesn't create cell") }
                return cell
            case 1:
                guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewPlaceInfoCell.identifier, for: indexPath) as? NewPlaceInfoCell
                else { fatalError("Doesn't create cell") }
                cell.set(labelName: "Name", textFieldName: "Place name", delegate: navigationItem.rightBarButtonItem)
                return cell
            case 2:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewPlaceInfoCell.identifier, for: indexPath) as? NewPlaceInfoCell
                else { fatalError("Doesn't create cell") }
                cell.set(labelName: "Location", textFieldName: "Location name", delegate: nil)
                return cell
            case 3:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewPlaceInfoCell.identifier, for: indexPath) as? NewPlaceInfoCell
                else { fatalError("Doesn't create cell") }
                cell.set(labelName: "Type", textFieldName: "Type name", delegate: nil)
                return cell
            default:
                fatalError("Doesn't create cell")
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
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")

            let actionSheet = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .actionSheet
            )
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseCamera()
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker()
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
}

extension NewPlaceViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func chooseCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.cameraCaptureMode = .photo
        present(imagePicker, animated: true)
    }

    private func chooseImagePicker() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        guard
                            let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                                as? NewPlacePhotoCell
                        else { return }
                        cell.imageOfPlace.image = image
                        cell.imageOfPlace.contentMode = .scaleAspectFill
                        cell.imageOfPlace.clipsToBounds = true
                    }
                }
            })
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
        navigationItem.rightBarButtonItem?.isEnabled = false
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

