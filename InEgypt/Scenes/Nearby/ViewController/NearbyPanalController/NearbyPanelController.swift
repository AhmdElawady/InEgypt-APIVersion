//
//  NearbyPanelController.swift
//  InEgypt
//
//  Created by Awady on 10/9/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

protocol SliderDelegate: AnyObject {
    func sliderEndMove(value: Float)
}

class NearbyPanelController: BaseCollectionViewController {
    
    var nearby: [HomeAround] = []
    weak var sliderDelegate: SliderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.register(ResultsNearbyCell.self, forCellWithReuseIdentifier: "ResultsNearbyCell")
        collectionView.register(NearbyHeaderPanelView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NearbyHeaderPanelView")
        activityIndicatorView.stopAnimating()
        collectionView.collectionViewLayout = nearbySectionLayout()
    }
    
    func reloadSectionLayout() {
        collectionView.reloadData()
        collectionView.collectionViewLayout = nearbySectionLayout()
    }
}

extension NearbyPanelController {
    
    private func nearbySectionLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let height: CGFloat = 180
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(height+60), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let sectionHeader = createSectionHeader()
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: NearbyEmptyBackgroundView.reuseIdentifier)
        nearby.isEmpty ? (section.decorationItems = [backgroundItem]) : (section.decorationItems = [])
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(NearbyEmptyBackgroundView.self, forDecorationViewOfKind: NearbyEmptyBackgroundView.reuseIdentifier)
        
        return layout
    }
    
    
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerHeight: CGFloat = 110
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        layoutSectionHeader.pinToVisibleBounds = true
        
        return layoutSectionHeader
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NearbyHeaderPanelView", for: indexPath) as? NearbyHeaderPanelView else { return UICollectionReusableView() }
        header.resultLabel.text = "\(nearby.count)"
        header.sliderCallback = { value in self.sliderDelegate?.sliderEndMove(value: value) }
        return header
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nearby.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultsNearbyCell", for: indexPath) as? ResultsNearbyCell else { return UICollectionViewCell() }
        cell.configData(data: nearby[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = nearby[indexPath.item].id
        
        let detailsController = DetailsController()
        let detailsPresenter = DetailsPresenter(view: detailsController, id: id)
        detailsController.presenter = detailsPresenter
        self.navigationController?.pushViewController(detailsController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView is UICollectionView {
//            let collectionViewCenter = CGPoint(x: collectionView.bounds.size.width / 2 + collectionView.contentOffset.x, y: collectionView.bounds.size.height / 2 + collectionView.contentOffset.y)
//            let centredCellIndexPath = collectionView.indexPathForItem(at: collectionViewCenter)
//
//            guard let path = centredCellIndexPath else {
//                // There is no cell in the center of collection view (you might want to think what you want to do in this case)
//                return
//            }
//
//            if let selectedAnnotation = mapView.selectedAnnotations.first {
//                // Ignore if correspondent annotation is already selected
//                if selectedAnnotation.isEqual(self.mapView.annotations[path.row]) {
//                    self.mapView.selectAnnotation(self.mapView.annotations[path.row], animated: true)
//                }
//            }
//        }
//    }
}
