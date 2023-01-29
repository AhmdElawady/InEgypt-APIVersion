//
//  CitiesController.swift
//  InEgypt
//
//  Created by Awady on 4/18/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CitiesController: BaseCollectionViewController {
    
    var cities: [CityItem] = []
    var searchedCities: [CityItem] = []
    var isSearched: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupController()
        fetchData()
    }
    
    private func setupController() {
        navigationItem.title = "Cities".localized
        collectionView.register(CitiesCell.self, forCellWithReuseIdentifier: "CitiesCell")
        setupSearchButton()
        addSearchBar()
        collectionView.collectionViewLayout = createLayout()
        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
    }
    
    var searchButton: UIBarButtonItem!
    var searchController: UISearchController!
    private func setupSearchButton() {
        searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.blackToWhite).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem = searchButton
    }

    @objc func showSearchBar(_ sender: Any) {
        let sb: UISearchBar = searchController.searchBar
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            if #available(iOS 13, *) {
                self.navigationItem.searchController = self.searchController
            }
        }, completion: { (status) in
            sb.becomeFirstResponder()})
    }

    func addSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search".localized
        LocalizationManager.shared.getLanguage() == .arabic ?
            (searchController.searchBar.searchTextField.textAlignment = .right) :
            (searchController.searchBar.searchTextField.textAlignment = .left)
    }
    
    func fetchData() {
        CityInteractor.shared.fetchCities { cities, error in
            if error != nil { print("City error") }
            guard let cities = cities?.data else { return }
            self.searchedCities = cities
            self.cities = cities
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets.bottom = 6
        
        let deviceType = UIDevice.current.deviceSize
        let height: CGFloat = deviceType == .iPad ? 300 : 210
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: 1)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13)
        
        let layout = UICollectionViewCompositionalLayout(section: layoutSection)
        
        return layout
    }

    // MARK: - Table view data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedCities.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitiesCell", for: indexPath) as? CitiesCell else { return UICollectionViewCell() }
        cell.configure(data: searchedCities[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let id = cities[indexPath.row].id
        let cityController = CityController()
        let cityPresenter = CityPresenter(view: cityController, id: id)
        cityController.presenter = cityPresenter
        self.navigationController?.pushViewController(cityController, animated: true)
    }
    
    @objc private func tryAgainButtonSelected() {
        fetchData()
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }
}


// MARK: SearchBar Delegate

extension CitiesController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            isSearched = true
            searchedCities = cities
            collectionView.reloadData()
            return
        }
        searchedCities = cities.filter({ (category) -> Bool in
        category.title.lowercased().contains(searchText.lowercased())})
        
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Cancel".localized, for: .normal)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedCities = cities
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

