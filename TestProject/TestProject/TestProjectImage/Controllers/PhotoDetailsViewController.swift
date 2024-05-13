//
//  PhotoDetailsViewController.swift
//  TestProject
//
//  Created by emil kurbanov on 13.05.2024.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    let photoImageView = UIImageView()
    let closeButton = UIButton()
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let descriptionImage = UILabel()
    
    var photo: Photo

    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(handleTapImage(_:)))
        let tapGestureView = UITapGestureRecognizer(target: self, action: #selector(handleTapView(_:)))
        photoImageView.addGestureRecognizer(tapGestureImage)
        photoImageView.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureView)
    }

    func setupViews() {
        photoImageView.kf.setImage(with: photo.imageURL)
        photoImageView.contentMode = .scaleAspectFill//.scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImageView)

        nameLabel.text = photo.userName
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        countLabel.text = "Количество загрузок: \(photo.totalPhoto)"
        countLabel.textColor = .black
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countLabel)
        
        descriptionImage.text =  "Описание: \(photo.description)"
        descriptionImage.textColor = .black
        descriptionImage.numberOfLines = 0
        descriptionImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionImage)

        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

  
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            descriptionImage.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 8),
            descriptionImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            photoImageView.topAnchor.constraint(equalTo: descriptionImage.bottomAnchor, constant: 16),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    @objc func handleTapView (_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)

        if !photoImageView.frame.contains(touchPoint) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleTapImage(_ gesture: UITapGestureRecognizer) {
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.image = photoImageView.image
        fullScreenVC.modalPresentationStyle = .fullScreen
        present(fullScreenVC, animated: true, completion: nil)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

