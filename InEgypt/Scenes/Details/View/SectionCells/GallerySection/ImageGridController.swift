//
//  ImageGridController.swift
//  InEgypt
//
//  Created by Awady on 6/25/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class ImageGridController: BaseCollectionViewController {
    
    var id = Int()
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
    
    var gallary: [ImageData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
        collectionView.collectionViewLayout = createGridLayout()
        self.collectionView.register(GallaryCell.self, forCellWithReuseIdentifier: "GallaryCell")
    }
    
    func createGridLayout() -> UICollectionViewLayout {
        let fullPhotoItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3)))

        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Second type: Main with pair
        // 3
        let mainItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1)))

        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        // 2
        let pairItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))

        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let trailingGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitem: pairItem, count: 2)

        // 1
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(4/9)), subitems: [mainItem, trailingGroup])

        // Third type. Triplet
        let tripletItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))

        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let tripletGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/9)), subitems: [tripletItem, tripletItem, tripletItem])

        // Fourth type. Reversed main with pair
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(4/9)), subitems: [trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(16/9)), subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func fetchImages() {
        DetailsInteractor.shared.fetchGallary(id: id) { gallary, error in
            if error != nil { print("Grid gallary error") }
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.gallary = gallary?.data ?? []
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallary.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCell", for: indexPath) as? GallaryCell else { return UICollectionViewCell() }
        cell.displayImage(data: gallary[indexPath.item].image)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageZoomingVC = ImageZoomingController()
        imageZoomingVC.selectedIndexPath = indexPath.item
        imageZoomingVC.images = gallary
        imageZoomingVC.modalPresentationStyle = .overCurrentContext
        self.present(imageZoomingVC, animated: true, completion: nil)
    }
}
