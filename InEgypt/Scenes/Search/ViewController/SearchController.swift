//
//  DestinationController.swift
//  InEgypt
//
//  Created by Awady on 11/29/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class SearchController: BaseCollectionViewController, UITableViewDelegate {
    
    var presenter: SearchPresenter!
    
    var searchControllerUI: UISearchController!
    var searchResultsController: SearchResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        
        setupController()
        presenter.fetchData()
    }
    
    private func setupController() {
        navigationItem.title = "Search".localized
        navigationItem.largeTitleDisplayMode = .always
        setupAroundBarButton()
        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
        
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderView")
        collectionView.register(SearchCategoryCell.self, forCellWithReuseIdentifier: "SearchCategoryCell")
        collectionView.register(SearchCityCell.self, forCellWithReuseIdentifier: "SearchCityCell")
        collectionView.register(DestinationCell.self, forCellWithReuseIdentifier: "DestinationCell")
        addSearchBar()
    }
    
    private func setupAroundBarButton() {
        let image = UIImage(systemName: "location.circle")?.imageFlippedForRightToLeftLayoutDirection()
        let customizedImage = image?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        let nearbyButton = UIBarButtonItem(image: customizedImage, style: .plain, target: self, action: #selector (nearbySelected))
        navigationItem.rightBarButtonItems = [nearbyButton]
    }
    
    @objc private func nearbySelected() {
        let aroundController = NearbyController()
        navigationController?.pushViewController(aroundController, animated: true)
    }
    
    private func addSearchBar() {
        searchResultsController = SearchResultsController()
        searchResultsController.tableView.delegate = self
        searchControllerUI = UISearchController(searchResultsController: searchResultsController)
        searchControllerUI.searchResultsUpdater = searchResultsController

        searchControllerUI.searchBar.searchBarStyle = .minimal
        searchControllerUI.obscuresBackgroundDuringPresentation = false
        searchControllerUI.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchControllerUI.searchBar.delegate = self
        searchControllerUI.searchBar.becomeFirstResponder()
        definesPresentationContext = true

        searchControllerUI.searchBar.placeholder = "Search Destinations".localized
        LocalizationManager.shared.getLanguage() == .arabic ?
            (searchControllerUI.searchBar.searchTextField.textAlignment = .right) :
            (searchControllerUI.searchBar.searchTextField.textAlignment = .left)
        
        self.navigationItem.searchController = self.searchControllerUI
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let titleHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderView", for: indexPath) as? SearchHeaderView else { return UICollectionReusableView() }
        switch indexPath.section {
//        case 0: break
        case 0: titleHeader.titleLabel.text = "Categories & Activities".localized
        case 1: titleHeader.titleLabel.text = "Cities".localized
        case 2: titleHeader.titleLabel.text = "Explore".localized
        default: break
        }
        return titleHeader
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return presenter.categories.count
        case 1: return presenter.cities.count
        case 2: return presenter.attractions.count
        default: return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCell", for: indexPath) as? SearchCategoryCell else { return UICollectionViewCell() }
            presenter.configureCategories(cell: cell, imageView: cell.iconImageView, for: indexPath.item)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCityCell", for: indexPath) as? SearchCityCell else { return UICollectionViewCell() }
            presenter.configureCities(cell: cell, imageView: cell.imageView, for: indexPath.item)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as? DestinationCell else { return UICollectionViewCell() }
            presenter.configureAttractions(cell: cell, imageView: cell.imageView, for: indexPath.item)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            presenter.didSelectCategory(at: indexPath.item)
        case 1:
            presenter.didSelectCity(at: indexPath.item)
        case 2:
            presenter.didSelectAttraction(at: indexPath.item)
            collectionView.deselectItem(at: indexPath, animated: false)
        default:
            print("Selected case not available")
        }
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDestination = searchResultsController.searchResults[indexPath.row]
        
        let detailsController = DetailsController()
        let detailsPresenter = DetailsPresenter(view: detailsController, id: selectedDestination.id)
        detailsController.presenter = detailsPresenter
        self.navigationController?.pushViewController(detailsController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    @objc private func tryAgainButtonSelected() {
        presenter.fetchData()
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }
}

