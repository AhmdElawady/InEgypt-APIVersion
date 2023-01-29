//
//  CityDestinationsController.swift
//  InEgypt
//
//  Created by Awady on 5/20/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CityDestinationsController: BaseCollectionViewController {
    
    var id = Int()
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
    
    let segmentedControl = UISegmentedControl(items: ["Attractions".localized, "Spots".localized])
    
    var cityTitle = ""
    var latitude = ""
    var longitude = ""
    var weather = ""
    var attractions: [CityDestination] = []
    var spots: [CityDestination] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        fetchData()
    }
    
    private func setupController() {
        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
        navigationItem.title = "In".localized + cityTitle
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.titleView = segmentedControl
        collectionView.showsVerticalScrollIndicator = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegmentedSelection), for: .valueChanged)
        collectionView.register(CityDestinationCell.self, forCellWithReuseIdentifier: "CityDestinationCell")
        setupGridButton()
    }
    
    @objc func handleSegmentedSelection() {
        segmentedControl.selectedSegmentIndex == 1 ? transitionAnimation(direction: .fromRight) : transitionAnimation(direction: .fromLeft) 
        collectionView.reloadData()
    }
    
    var gridButton: UIBarButtonItem!
    private func setupGridButton() {
        gridButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.2x2.fill")?.withTintColor(.blackToWhite).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(gridButtonPressed))
        navigationItem.rightBarButtonItem = gridButton
    }
    
    @objc private func gridButtonPressed() {
        let sysImages = ["rectangle.grid.2x2.fill", "rectangle.grid.3x2.fill", "rectangle.grid.1x2.fill"]
        numberOfColums < 3 ? numberOfColums += 1 : (numberOfColums = 1)
        UIView.transition(with: collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.gridButton.image = UIImage(systemName: sysImages[Int(self.numberOfColums)-1])?.withTintColor(.blackToWhite, renderingMode: .alwaysOriginal)
            self.collectionView.reloadData()
        }, completion: nil)
    }
    
    func fetchData() {
        CityInteractor.shared.fetchAllCityDestinations(id: id) { destinations, error in
            if error != nil { print("City destinations error") }
            self.attractions = destinations?.data.attraction ?? []
            self.spots = destinations?.data.spot ?? []
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0: return attractions.count
        case 1: return spots.count
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityDestinationCell", for: indexPath) as? CityDestinationCell else { return UICollectionViewCell() }
        switch segmentedControl.selectedSegmentIndex {
        case 0: cell.configData(data: attractions[indexPath.item])
        case 1: cell.configData(data: spots[indexPath.item])
        default: break
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    var numberOfColums: CGFloat = 1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width - 24
        let xInsets: CGFloat = 3
        let cellSpacing: CGFloat = (xInsets*numberOfColums)-xInsets
        let size = (width/numberOfColums) - (xInsets + cellSpacing)
        let height = numberOfColums == 1 ? size-150 : size
        return CGSize(width: size, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 20 }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var id: Int = Int()
        switch segmentedControl.selectedSegmentIndex {
        case 0: id = attractions[indexPath.item].id
        case 1: id = spots[indexPath.item].id
        default: break
        }
        let detailsController = DetailsController()
        let detailsPresenter = DetailsPresenter(view: detailsController, id: id)
        detailsController.presenter = detailsPresenter
        self.navigationController?.pushViewController(detailsController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    @objc private func tryAgainButtonSelected() {
        fetchData()
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }}
