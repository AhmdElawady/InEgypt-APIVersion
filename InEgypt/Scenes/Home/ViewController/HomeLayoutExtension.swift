//
//  HomeLayoutExtension.swift
//  InEgypt
//
//  Created by Awady on 9/13/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

extension HomeController {
    
    private func topAdsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let deviceType = UIDevice.current.deviceSize
        let height: CGFloat = deviceType == .iPad ? 280 : 170
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .paging
        
        layoutSection.visibleItemsInvalidationHandler = { items, offset, environment in
            self.currentPageIndex = items.last!.indexPath.item
        }
        
        return layoutSection
    }
    
    private func recommendedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let height: CGFloat = 150
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(height+80), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return layoutSection
    }
    
    private func featuredSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let width: CGFloat = view.frame.width
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(280))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    private func nearbySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let height: CGFloat = 180
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(height+60), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
//        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: AroundBackgroundView.reuseIdentifier)
//        presenter.aroundByDistance.isEmpty ? (layoutSection.decorationItems = [backgroundItem]) : (layoutSection.decorationItems = [])
        
        return layoutSection
    }
    
    private func citySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let height: CGFloat = 180
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(height), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return layoutSection
    }
    
    internal func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .fractionalWidth(0))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            let emptySection = NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [layoutItem]))
            
            let sectionLayoutKind = SectionTitle.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .topAds : return self.topAdsSection()
            case .attractions: return self.recommendedSection()
            case .spots: return self.recommendedSection()
            case .featured: return self.featuredSection()
            case .nearby: if self.presenter.aroundByDistance.isEmpty {
                return emptySection
            } else { return self.nearbySection() }
                
            case .cities: return self.citySection()
            }
        }
//        layout.register(AroundBackgroundView.self, forDecorationViewOfKind: AroundBackgroundView.reuseIdentifier)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        return layout
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerHeight: CGFloat = 40
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        layoutSectionHeader.pinToVisibleBounds = true
        
        return layoutSectionHeader
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TitleHeaderView", for: indexPath) as? TitleHeaderView else { return UICollectionReusableView() }
        
        switch indexPath.section {
        case 0: break
        case 1:
            header.titleLabel.text = presenter.recommendedHeader
            header.moreButton.setTitle("", for: .normal)
        case 2:
            header.titleLabel.text = presenter.categoryAttractionHeader
            header.moreButton.setTitle("", for: .normal)
        case 4:
            guard let nearbyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NearbyHeaderView", for: indexPath) as? NearbyHeaderView else { return UICollectionReusableView() }
            nearbyHeader.customButton.addTarget(self, action: #selector(customNearbyPressed), for: .touchUpInside)
            return nearbyHeader
        case 5:
            header.titleLabel.text = "Explore Cities".localized
            header.moreButton.setTitle("More".localized, for: .normal)
            header.moreButton.tag = 4
            header.moreButton.addTarget(self, action: #selector(citySeeMorePressed), for: .touchUpInside)
        default: break
        }
        return header
    }
    
    @objc private func citySeeMorePressed(sender: UIButton) {
        guard sender.tag == 4 else { return }
        let citiesController = CitiesController()
        navigationController?.pushViewController(citiesController, animated: true)
    }
    
    @objc private func customNearbyPressed(sender: UIButton) {
        let aroundController = NearbyController()
        navigationController?.pushViewController(aroundController, animated: true)
    }
    
    
    override internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    override internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return presenter.ads.count
        case 1: return presenter.attractions.count
        case 2: return presenter.categoryAttractions.count
        case 3: return 1
        case 4: return presenter.aroundByDistance.count
        case 5: return presenter.cities.count
        default: return 1
        }
    }

    override internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopAdsCell", for: indexPath) as? TopAdsCell else { return UICollectionViewCell() }
            presenter.configureAds(cell: cell, imageView: cell.adsImageView, for: indexPath.item)
            return cell
            
        case 1, 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationsCell", for: indexPath) as? DestinationsCell else { return UICollectionViewCell() }
            switch indexPath.section {
            case 1: presenter.configureHeddinGems(cell: cell, imageView: cell.imageView, for: indexPath.item)
            case 2: presenter.configureCategory(cell: cell, imageView: cell.imageView, for: indexPath.item)
            default: break
            }
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as? FeaturedCell else { return UICollectionViewCell() }
            presenter.configureFeatureImage(cell: cell, imageView: cell.imageView)
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeNearbyCell", for: indexPath) as? HomeNearbyCell else { return UICollectionViewCell() }
            presenter.configureAround(cell: cell, imageView: cell.imageView, for: indexPath.item)
            return cell
            
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as? CityCell else { return UICollectionViewCell() }
            presenter.configureCities(cell: cell, imageView: cell.backgroundImageView, for: indexPath.item)
            cell.destinationButton.tag = indexPath.item
            cell.destinationButton.addTarget(self, action: #selector(cityDestinationButtonSelected), for: .touchUpInside)
            return cell
            
        default: return UICollectionViewCell()
        }
    }

    @objc private func cityDestinationButtonSelected(sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: buttonPostion) {
            let cityDestinations = CityDestinationsController(id: presenter.cities[indexPath.item].id)
            cityDestinations.cityTitle = presenter.cities[indexPath.row].title
            navigationController?.pushViewController(cityDestinations, animated: true)
        }
    }
    
    override internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0, 3:  break
        case 1, 2: presenter.didSelectAttraction(at: indexPath)
        case 4: presenter.didSelectAround(at: indexPath.item)
        case 5: presenter.didSelectCity(at: indexPath.item)
            
        default: break
        }
    }
}
