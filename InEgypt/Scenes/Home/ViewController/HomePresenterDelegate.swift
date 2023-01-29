//
//  HomePresenterDelegate.swift
//  InEgypt
//
//  Created by Awady on 9/21/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation

extension HomeController: HomeView {
 
    func showIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout = self.createLayout()
        }
    }
    
    func showError() { print("error") }
    
    func navigateToDetailsController(id: Int) {
        let detailsController = DetailsController()
        let detailsPresenter = DetailsPresenter(view: detailsController, id: id)
        detailsController.presenter = detailsPresenter
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func navigateToCityController(id: Int) {
        let cityController = CityController()
        let cityPresenter = CityPresenter(view: cityController, id: id)
        cityController.presenter = cityPresenter
        self.navigationController?.pushViewController(cityController, animated: true)
    }
}
