//
//  SpotController.swift
//  InEgypt
//
//  Created by Awady on 8/22/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

//import UIKit
//
//
//class SpotController: BaseCollectionViewController {
//
//    var id = Int()
//    convenience init(id: Int) {
//        self.init()
//        self.id = id
//    }
//
//    let deviceType = UIDevice.current.deviceSize
//    var info: Info?
//    var gallary: [ImageData] = []
//    var categories: [PlaceSection] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        registerCells()
//        fetchData()
//        RetryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
//    }
//
//    private func registerCells() {
//        collectionView.register(SpotPosterCell.self, forCellWithReuseIdentifier: "SpotPosterCell")
//        collectionView.register(SpotDescriptionCell.self, forCellWithReuseIdentifier: "SpotInfoCell")
//        collectionView.register(SpotMapCell.self, forCellWithReuseIdentifier: "SpotMapCell")
//    }
//
//    fileprivate func fetchData() {
//        let dispatchGroup = DispatchGroup()
//
//        var detailsInfo: Info?
//        var detailsGallary: [ImageData] = []
//        var detailsCategory: [PlaceSection] = []
//
//        dispatchGroup.enter()
//        DetailsInteractor.shared.fetchInfo(id: id) { info, error in
//            if error != nil { print("Details info error") }
//            dispatchGroup.leave()
//            detailsInfo = info?.data
//        }
//
//        dispatchGroup.enter()
//        DetailsInteractor.shared.fetchGallary(id: id) { gallary, error in
//            if error != nil { print("Details gallary error") }
//            dispatchGroup.leave()
//            detailsGallary = gallary?.data ?? []
//        }
//
//        dispatchGroup.enter()
//        DetailsInteractor.shared.fetchCategories(id: id) { category, error in
//            if error != nil { print("around error") }
//            guard let category = category else { return }
//            dispatchGroup.leave()
//            detailsCategory = category.data
//        }
//
//        dispatchGroup.notify(queue: .main) { [self] in
//            activityIndicatorView.stopAnimating()
//            info = detailsInfo
//            gallary = detailsGallary
//            categories = detailsCategory
//            navigationItem.title = info?.title
//            collectionView.reloadData()
//            collectionView.collectionViewLayout = createCompositionalLayout()
//        }
//    }
//
//
//    func posterSection() -> NSCollectionLayoutSection {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let width: CGFloat = view.frame.width
//        let height: CGFloat = 0.35*view.frame.height
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
//        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//
//        return layoutSection
//    }
//
//    func mapSection() -> NSCollectionLayoutSection {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let width: CGFloat = view.frame.width
//        let height: CGFloat = deviceType == .iPad ? 330 : 250
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
//        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 1)
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//
//        return layoutSection
//    }
//
//    func aboutSection() -> NSCollectionLayoutSection {
//
//        let estimatedHeight = CGFloat(400)
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let width: CGFloat = view.frame.width
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .estimated(estimatedHeight))
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: 1)
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//
//        return layoutSection
//    }
//
//    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout { [weak self] (index, environmnt) -> NSCollectionLayoutSection? in
//            return self?.createCollectionViewLayout(index: index, environmnt: environmnt)
//        }
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 10
//        layout.configuration = config
//        return layout
//    }
//
//    func createCollectionViewLayout(index: Int, environmnt: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//        switch index {
//        case 0: return posterSection()
//        case 1: return mapSection()
//        case 2: return aboutSection()
//        default: return posterSection()
//        }
//    }
//
//    // MARK: UICollectionViewDataSource
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:  return gallary.count
//        case 1, 2: return info == nil ? 0 : 1
//        default: fatalError()
//        }
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//        case 0:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotPosterCell", for: indexPath) as? SpotPosterCell else { return UICollectionViewCell() }
//            cell.displayImage(data: gallary[indexPath.item])
//            return cell
//        case 1:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotMapCell", for: indexPath) as? SpotMapCell else { return UICollectionViewCell() }
//            guard let info = info else { return cell }
//            cell.configureData(title: info.title, category: categories[0])
////            cell.mapViewController.configureData(info: info)
//            return cell
//        case 2:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotInfoCell", for: indexPath) as? SpotDescriptionCell else { return UICollectionViewCell() }
//            guard let info = info else { return cell }
//            cell.aboutLabel.text = info.description
//            return cell
//
//        default: return UICollectionViewCell()
//        }
//    }
//
//    @objc private func retryButtonPressed() { // no connection view button
//        fetchData()
//        if NetworkMonitor.shared.isActive {
//            noConnectionView.removeFromSuperview()
//        }
//    }
//}
