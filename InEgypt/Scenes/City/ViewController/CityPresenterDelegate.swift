//
//  CityPresenterDelegate.swift
//  InEgypt
//
//  Created by Awady on 10/7/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation

extension CityController: CityView {
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
        }
    }
    
    func showError() {
        print("error")
    }
    
    func navigateToDetailsController(id: Int) {
        let detailsController = DetailsController()
        let detailsPresenter = DetailsPresenter(view: detailsController, id: id)
        detailsController.presenter = detailsPresenter
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
