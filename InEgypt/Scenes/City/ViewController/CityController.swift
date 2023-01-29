//
//  CityController.swift
//  InEgypt
//
//  Created by Awady on 11/20/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class CityController: BaseCollectionViewController {
    
    var presenter: CityPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchCityInfo()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavHidden()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

    fileprivate func setupCollectionView() {
//        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CityHeaderLayout())
        collectionView.backgroundColor = .backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(CityHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CityHeaderView")
        collectionView!.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
        collectionView.register(DestinationSectionCell.self, forCellWithReuseIdentifier: "DestinationSectionCell")
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            if kind == UICollectionView.elementKindSectionFooter {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as? FooterView else { return UICollectionReusableView() }
                if let cityInfo = presenter.cityInfo { footer.overviewLabel.text = cityInfo.about }
                return footer
            }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CityHeaderView", for: indexPath) as? CityHeaderView else { return UICollectionReusableView() }
//            if let cityInfo = cityInfo { header.configureInfo(data: cityInfo) }
            presenter.configureInfo(cell: header, imageView: header.backgroundImageView)
            header.getAroundButton.addTarget(self, action: #selector(openLocation), for: .touchUpInside)
            return header
        }
        return UICollectionReusableView()
    }

    @objc private func openLocation() {
        guard let city = presenter.cityInfo else { return }
        let cityMapController = CityMapController(id: city.id, latitude: city.latitude, longitude: city.longitude)
        present(cityMapController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .init(width: view.frame.width, height: view.frame.height)
        }
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            let indexPath = IndexPath(row: 0, section: section)
            let footerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)
            
            return footerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        }
        
        return .init()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationSectionCell", for: indexPath) as? DestinationSectionCell else { return UICollectionViewCell() }
            cell.destinationsViewController.fetchCityData(id: presenter.id)
                        cell.seeAllButton.addTarget(self, action: #selector(seeAllPressed), for: .touchUpInside)
                        cell.destinationsViewController.didSelectItem = { id in
                            let detailsController = DetailsController()
                            let detailsPresenter = DetailsPresenter(view: detailsController, id: id)
                            detailsController.presenter = detailsPresenter
                            self.navigationController?.pushViewController(detailsController, animated: true)
                        }
                        return cell
                    }
        return UICollectionViewCell()
    }

    @objc private func seeAllPressed() {
        guard let cityInfo = presenter.cityInfo else { return }
        let destinationsVC = CityDestinationsController(id: cityInfo.id)
        destinationsVC.cityTitle = cityInfo.title
        destinationsVC.latitude = cityInfo.latitude
        destinationsVC.longitude = cityInfo.longitude
        
        self.navigationController?.pushViewController(destinationsVC, animated: true)
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceType = UIDevice.current.deviceSize
        let height: CGFloat = deviceType == .iPad ? 930 : 630
        if indexPath.section == 1 {
            return CGSize(width: view.frame.size.width, height: height)
        }
        return .init()
    }

    var contentOffset: CGFloat = 0
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset = scrollView.contentOffset.y
        handleNavHidden()
    }

    private func handleNavHidden() {
        if contentOffset >= 650 {
            navigationItem.title = presenter.cityInfo?.title
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        } else {
            navigationItem.title = ""
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
    
//    @objc private func tryAgainButtonSelected() {
//        presenter.fetchCityInfo()
//        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
//    }
}
