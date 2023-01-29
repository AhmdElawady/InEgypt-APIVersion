//
//  PresenterDelegateExtension.swift
//  InEgypt
//
//  Created by Awady on 9/25/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

extension DetailsController: DetailsView {
    
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
    
    func showError() {
        print("error")
    }
    
    func navigateToAboutController(title: String, description: String) {
        let aboutController = AboutController()
        aboutController.titleLabel.text = title
        aboutController.descriptionContentLabel.text = description
        aboutController.modalTransitionStyle = .crossDissolve
        aboutController.modalPresentationStyle = .overCurrentContext
        present(aboutController, animated: true, completion: nil)
    }
    
//    func navigateToGallaryGridController(id: Int) {
//
//    }
    
    func navigateToImageController(gallary: [ImageData], index: Int) {
        let imageZoomingVC = ImageZoomingController()
        imageZoomingVC.selectedIndexPath = index
        imageZoomingVC.images = gallary
        imageZoomingVC.modalPresentationStyle = .overCurrentContext
        self.present(imageZoomingVC, animated: true, completion: nil)
    }
    
    func navigateToSpotController(id: Int) {
        let detailsController = DetailsController()
        let presenter = DetailsPresenter(view: detailsController, id: id)
        detailsController.presenter = presenter
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func navigateToAddReviewController(id: Int) {
        
    }
    
    func navigateToReviewController(review: Review) {
        let reviewController = ReviewController()
        reviewController.configureReview(review: review)
        self.present(reviewController, animated: true, completion: nil)
    }
    
}
