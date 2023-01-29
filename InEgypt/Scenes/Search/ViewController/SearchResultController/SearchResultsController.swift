//
//  SearchController.swift
//  InEgypt
//
//  Created by Awady on 1/30/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let indecator = UIActivityIndicatorView(style: .medium)
        indecator.color = .systemGray
        indecator.startAnimating()
        indecator.hidesWhenStopped = true
        return indecator
    }()
    
    var searchResults: [Search] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupController()
    }
    
    private func setupController() {
        tableView.addSubview(activityIndicatorView)
        activityIndicatorView.anchor(top: view.topAnchor)
        activityIndicatorView.anchorCenterXToSuperview()
        tableView.backgroundColor = .backgroundColor
        tableView.register(SearchedCell.self, forCellReuseIdentifier: "SearchedCell")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        print(searchText)

        DestinationService.shared.fetchSearched(searchTerm: searchText) { response, error in
            if error != nil { print("Destination search error") }
            if let results = response?.data?.result {
                self.searchResults = results
            }
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedCell", for: indexPath) as? SearchedCell else { return UITableViewCell() }
        cell.configureDestination(data: searchResults[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
