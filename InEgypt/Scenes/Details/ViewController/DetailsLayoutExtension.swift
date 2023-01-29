//
//  DetailsLayoutExtension.swift
//  InEgypt
//
//  Created by Awady on 9/25/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

extension DetailsController {
    
    internal func registerCells() {
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: "PosterCell")
        collectionView.register(DetailsSectionCell.self, forCellWithReuseIdentifier: "DetailsSectionCell")
        collectionView.register(AboutSectionCell.self, forCellWithReuseIdentifier: "AboutSectionCell")
        collectionView.register(GallaryCell.self, forCellWithReuseIdentifier: "GallaryCell")
        collectionView.register(MapSectionCell.self, forCellWithReuseIdentifier: "MapSectionCell")
        collectionView.register(NearbySectionCell.self, forCellWithReuseIdentifier: "NearbySectionCell")
        collectionView.register(TicketSectionCell.self, forCellWithReuseIdentifier: "TicketSectionCell")
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: "ReviewCell")
        collectionView.register(GalleryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MoreHeaderView")
        collectionView.register(DetailsTitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailsTitleHeaderView")
        collectionView.register(ReviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReviewHeaderView")
        collectionView.register(ReviewFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ReviewFooterView")
    }
    
    private func posterSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let width: CGFloat = view.frame.width
        let height: CGFloat = 0.35*view.frame.height
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    private func infoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let width: CGFloat = view.frame.width
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(150))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    private func descriptionSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func gallarySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let height: CGFloat = deviceType == .iPad ? 180 : 120
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(height+60), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func mapSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let height: CGFloat = deviceType == .iPad ? 230 : 170
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func nearbySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets.bottom = 8
        
//        let height: CGFloat = nearby.isEmpty ? 0 : 140
        let width: CGFloat = deviceType == .iPad ? 0.45 : 0.93
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .absolute(140))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 2)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func reviewSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let height: CGFloat = deviceType == .iPad ? 210 : 160
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSectionFooter = createSectionFooder()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader, layoutSectionFooter]
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: ReviewBackgroundView.reuseIdentifier)
        presenter.reviews.isEmpty ? (layoutSection.decorationItems = [backgroundItem]) : (layoutSection.decorationItems = [])
        
        return layoutSection
    }
    
    private func ticketSection() -> NSCollectionLayoutSection {
       
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let height: CGFloat = deviceType == .iPad ? 180 : 150

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSectionHeader = createSectionHeader()
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    internal func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .fractionalWidth(0))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            let emptySection = NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [layoutItem]))
            
            let sectionLayoutKind = DetailsSection.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .posterSection: return self.posterSection()
            case .infoSection: return self.infoSection()
            case .descriptionSection: return self.descriptionSection()
            case .gallarySection:
                if self.presenter.gallary.isEmpty {
                    return emptySection
                } else { return self.gallarySection() }
                
            case .mapSection: return self.mapSection()
            case .nearbySection:
                if self.presenter.nearby.isEmpty {
                    return emptySection
                } else { return self.nearbySection() }
                
            case .reviewSection: return self.reviewSection()
            case .ticketSection:
                if self.presenter.info?.ticketsPrice == nil {
                    return emptySection
                } else { return self.ticketSection() }
                
            }
        }
//        layout.register(GallaryBackgroundView.self, forDecorationViewOfKind: GallaryBackgroundView.reuseIdentifier)
        layout.register(ReviewBackgroundView.self, forDecorationViewOfKind: ReviewBackgroundView.reuseIdentifier)
//        layout.register(NearbyBackgroundView.self, forDecorationViewOfKind: NearbyBackgroundView.reuseIdentifier)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        return layout
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.absolute(40) )
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        layoutSectionHeader.pinToVisibleBounds = true
        
        return layoutSectionHeader
    }
    
    private func createSectionFooder() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerHeight: CGFloat = deviceType == .iPad ? 80 : 40
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.absolute(headerHeight) )
        let layoutSectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        return layoutSectionFooter
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let titleHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailsTitleHeaderView", for: indexPath) as? DetailsTitleHeaderView else { return UICollectionReusableView() }
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            switch indexPath.section {
            case 0, 1: break
            case 2: titleHeader.titleLabel.text = "Description".localized
            case 3:
                guard let gallaryHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MoreHeaderView", for: indexPath) as? GalleryHeaderView else { return UICollectionReusableView() }
                gallaryHeader.titleLabel.text = "Gallery".localized
                gallaryHeader.galleryButton.addTarget(self, action: #selector(openGrid), for: .touchUpInside)
                return gallaryHeader
                
            case 4: titleHeader.titleLabel.text = "Maps & Locations".localized
            case 5: titleHeader.titleLabel.text = "Nearby Spots".localized
            case 6:
                guard let reviewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReviewHeaderView", for: indexPath) as? ReviewHeaderView else { return UICollectionReusableView() }
                reviewHeader.ratingView.rating = Double(presenter.reviewsInfo?.avg ?? "0") ?? 0.0
                reviewHeader.rateCountLabel.text = "(\(presenter.reviewsInfo?.count ?? 0))"
                reviewHeader.titleLabel.text = "Ratings & Reviews".localized
                return reviewHeader
                
            case 7: titleHeader.titleLabel.text = "Ticket Prices".localized
            default: break
            }
            
        case UICollectionView.elementKindSectionFooter:
            if indexPath.section == 6 {
                guard let reviewFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ReviewFooterView", for: indexPath) as? ReviewFooterView else { return UICollectionReusableView() }
                reviewFooter.addReviewButton.addTarget(self, action: #selector(addReviewSelected), for: .touchUpInside)
                
                return reviewFooter
            }
        default: assert(false, "Unexpected element kind")
        }
        return titleHeader
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 4, 7: return presenter.info == nil ? 0 : 1
        case 3: return presenter.gallary.count
        case 5: return presenter.nearby.count
        case 6: return presenter.reviews.count
        default: return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as? PosterCell else { return UICollectionViewCell() }
            presenter.displayPoster(imageView: cell.posterImageView)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsSectionCell", for: indexPath) as? DetailsSectionCell else { return UICollectionViewCell() }
            presenter.configureInfo(cell: cell)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutSectionCell", for: indexPath) as? AboutSectionCell else { return UICollectionViewCell() }
            presenter.configureDescription(cell: cell)
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCell", for: indexPath) as? GallaryCell else { return UICollectionViewCell() }
            presenter.configureGallary(imageView: cell.imageView, for: indexPath.item)
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapSectionCell", for: indexPath) as? MapSectionCell else { return UICollectionViewCell() }
            presenter.configureMap(view: cell.mapViewController)
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbySectionCell", for: indexPath) as? NearbySectionCell else { return UICollectionViewCell() }
            presenter.configureNearby(cell: cell, imageView: cell.spotImageView, for: indexPath.item)
            cell.backgroundColor = .clear
            return cell
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
            presenter.configureReview(cell: cell, for: indexPath.item)
            return cell
        case 7:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketSectionCell", for: indexPath) as? TicketSectionCell else { return UICollectionViewCell() }
            presenter.configureTicket(cell: cell)
            return cell
        default: return UICollectionViewCell()
        }
    }
    
}
