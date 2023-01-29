//
//  SectionPlacesController.swift
//  InEgypt
//
//  Created by Awady on 12/5/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class SectionPlacesController: BaseCollectionViewController {
    
    var id = Int()
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
    
    var destinations: [SectionDestinations] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategoryData()
        setupNavigationBar()
        setupCollectionView()
        setupGridButton()
    }
    
    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = true
        navigationItem.largeTitleDisplayMode = .always
        collectionView.register(PlacesCell.self, forCellWithReuseIdentifier: "PlacesCell")
        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
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
    
    
    func fetchCategoryData() {
        SectionsService.shared.fetchCategoryPlaces(id: id) { destionations, error in
            if error != nil { print("CategoryPlaces error") }
            self.destinations = destionations?.data ?? []
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchActivityData(id: Int) {
        SectionsService.shared.fetchActivityPlaces(id: id) { destionations, error in
            if error != nil { print("ActivityPlaces error") }
            self.destinations = destionations?.data ?? []
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCell", for: indexPath) as? PlacesCell else { return UICollectionViewCell() }
        cell.configData(data: destinations[indexPath.item])
    
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
        UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 20 }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = destinations[indexPath.item].id
        let detailsController = DetailsController()
        let detailsPresenter = DetailsPresenter(view: detailsController, id: id)
        detailsController.presenter = detailsPresenter
        self.navigationController?.pushViewController(detailsController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    @objc private func tryAgainButtonSelected() {
        fetchCategoryData()
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }
}
