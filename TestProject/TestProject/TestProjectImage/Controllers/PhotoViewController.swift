//
//  PhotoViewController.swift
//  TestProject
//
//  Created by emil kurbanov on 13.05.2024.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhotoViewController: UIViewController {
    
    private enum Section {
        case main
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    
    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        loadAPI()
    }
    
    private func loadAPI() {
           NetworkService.shared.loadAPI { [weak self] photos in
               self?.applySnapshot(photos)
           }
       }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let horizontalSpacing: CGFloat = 10
        let itemWidth = (view.bounds.width - 2 * horizontalSpacing) / 2
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalSpacing, bottom: 0, right: horizontalSpacing)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        view.addSubview(collectionView)
    }


    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, photo: Photo) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else { fatalError("Cannot create new cell") }
           
            cell.configure(with: photo.imageURL)
            return cell
        }
    }
    
    private func applySnapshot(_ photos: [Photo]) {
           var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
           snapshot.appendSections([.main])
           snapshot.appendItems(photos)
           dataSource.apply(snapshot, animatingDifferences: true)
       }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhoto = dataSource.itemIdentifier(for: indexPath)
       
        guard let selectedPhoto = selectedPhoto else { return }
        let photoDetailsVC = PhotoDetailsViewController(photo: selectedPhoto)
        photoDetailsVC.modalPresentationStyle = .fullScreen
        present(photoDetailsVC, animated: true, completion: nil)
    }
}
