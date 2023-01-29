//
//  CityPlacesController.swift
//  InEgypt
//
//  Created by Awady on 5/1/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CityPlacesController: BaseCollectionViewController {
    
    enum SectionTitle: String, CaseIterable {
        case attractions = "Attraction"
        case spots = "Spots"
    }
    
    var attractions: [CityItems] = []
    var spots: [CityItems] = []
    
    var didSelectItem: ((Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCells()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func registerCells() {
        collectionView.register(CityDestinationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CityDestinationHeaderView")
        collectionView.register(CityAttractionCell.self, forCellWithReuseIdentifier: "CityAttractionCell")
        collectionView.register(CitySpotsCell.self, forCellWithReuseIdentifier: "CitySpotsCell")
    }
    
    func fetchCityData(id: Int) {
        guard attractions.isEmpty && spots.isEmpty else { self.activityIndicatorView.stopAnimating(); return }
        
        CityInteractor.shared.fetchCityTenAttraction(id: id) { cityDestination, error in
            if error != nil { print("City Attraction error") }
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.attractions = cityDestination?.data ?? []
                
                self.collectionView.reloadData()
            }
        }
        CityInteractor.shared.fetchCityTenSpots(id: id) { cityDestination, error in
            if error != nil { print("City Spots error") }
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.spots = cityDestination?.data ?? []
                
                self.collectionView.reloadData()
            }
        }
    }
    
    func attractionsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let deviceType = UIDevice.current.deviceSize
        let height: CGFloat = attractions.isEmpty ? 0 : (deviceType == .iPad ? 400 : 200)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func spotsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
        
        let deviceType = UIDevice.current.deviceSize
        let height: CGFloat = spots.isEmpty ? 30 : (deviceType == .iPad ? 230 : 150)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .absolute(height)), subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        layoutSection.contentInsets.bottom = 30
        
        let layoutSectionHeader = createSectionHeader()
        spots.isEmpty ? (layoutSection.boundarySupplementaryItems = []) : (layoutSection.boundarySupplementaryItems = [layoutSectionHeader])
        
        return layoutSection
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = SectionTitle.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .attractions: return self.attractionsSection()
            case .spots: return self.spotsSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        return layout
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return layoutSectionHeader
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CityDestinationHeaderView", for: indexPath) as? CityDestinationHeaderView else { return UICollectionReusableView() }
        switch indexPath.section {
        case 0: header.sectionTitleLabel.text = "ATTRACTIONS".localized
        case 1: header.sectionTitleLabel.text = "SPOTS".localized
        default: break
        }
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return attractions.count
        case 1: return spots.count
        default: return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityAttractionCell", for: indexPath) as? CityAttractionCell else { return UICollectionViewCell() }
            cell.configureData(data: attractions[indexPath.item])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitySpotsCell", for: indexPath) as? CitySpotsCell else { return UICollectionViewCell() }
            cell.configureData(data: spots[indexPath.item])
            return cell
        default: return UICollectionViewCell()
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: didSelectItem?(attractions[indexPath.item].id)
        case 1: didSelectItem?(spots[indexPath.item].id)
        default: break
        }
    }
}


class CityDestinationHeaderView: UICollectionReusableView {
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 20 : 14
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubview()
    }
    
    private func addSubview() {
        addSubview(sectionTitleLabel)
        sectionTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 5, rightConstant: 16)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
