//
//  CollectionViewController.swift
//  InEgypt
//
//  Created by Awady on 12/19/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit
import CoreLocation

class DetailsController: BaseCollectionViewController {
    
    enum DetailsSection: String, CaseIterable {
        case posterSection = "posterSection"
        case infoSection = "infoSection"
        case descriptionSection = "descriptionSection"
        case gallarySection = "gallarySection"
        case mapSection = "mapSection"
        case nearbySection = "nearbySection"
        case reviewSection = "reviewSection"
        case ticketSection = "ticketSection"
    }
    
    var presenter: DetailsPresenter!
    
    var info: Info?
    var gallary: [ImageData] = []
    var reviewsInfo: ReviewsInfo?
    var reviews: [Review] = []
    var nearby: [HomeAround] = []
    var categories: [PlaceSection] = []
    var isLiked: Bool = false
    
    let deviceType = UIDevice.current.deviceSize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInsetAdjustmentBehavior = .never
        registerCells()
        setupLikeButton()
        presenter.fetchData()
        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavHidden()
//        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    var likeButton = UIBarButtonItem()
    private func setupLikeButton() {
        if info?.like == 0 {
            likeButton.image = UIImage(systemName: "heart")?.withTintColor(.appBlue).withRenderingMode(.alwaysOriginal)
            isLiked = false
        } else {
            likeButton.image = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.9983811975, green: 0.3601943254, blue: 0.2774392366, alpha: 1)).withRenderingMode(.alwaysOriginal)
            isLiked = true
        }
        likeButton.target = self
        likeButton.action = #selector(likeButtonPressed)
    }
    
    func toggleLikeButton() {
        var image = UIImage(systemName: "")?.withTintColor(.appBlue)
        if isLiked {
            (image = UIImage(systemName: "heart")?.withTintColor(.appBlue))
            isLiked = false
        } else {
            (image = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.9983811975, green: 0.3601943254, blue: 0.2774392366, alpha: 1)))
            isLiked = true
        }
        likeButton.image = image?.withRenderingMode(.alwaysOriginal)
    }
    
    @objc private func likeButtonPressed() {
        DetailsInteractor.shared.postLikeUnlike(id: presenter.id) { isLiked, error in
            if error != nil { print("Details isLiked error") }
            DispatchQueue.main.async {
                self.toggleLikeButton()
            }
        }
    }
    
    @objc internal func openGrid(sender: UIButton) {
        let imageGridController = ImageGridController(id: presenter.id)
        guard let info = presenter.info else { return }
        imageGridController.title = info.title
        navigationController?.pushViewController(imageGridController, animated: true)
    }

    // MARK: UICollectionViewDelegate
    var contentOffset: CGFloat = 0
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset = scrollView.contentOffset.y
        handleNavHidden()
    }
    
    private func handleNavHidden() {
        if contentOffset >= 330 {
            navigationItem.title = presenter.info?.title
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationItem.rightBarButtonItems = [likeButton]
        } else {
            navigationItem.title = ""
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationItem.rightBarButtonItems = []
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2: presenter.didSelectAbout()
        case 3: presenter.didSelectImage(at: indexPath.item)
        case 5: presenter.didSelectNearby(at: indexPath.item)
        case 6: presenter.didSelectReview(at: indexPath.item)
        default: break
        }
    }
    
    @objc private func tryAgainButtonSelected() {
        presenter.fetchData()
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }
}


extension DetailsController: AddReviewDelegate {
    
    @objc internal func addReviewSelected() {
        let addReviewVC = AddReviewController()
        addReviewVC.addReviewDelegate = self
        addReviewVC.displayImage(data: presenter.info?.poster ?? "")
        addReviewVC.titleLabel.text = presenter.info?.title
        addReviewVC.id = presenter.id
        
        present(addReviewVC, animated: true, completion: nil)
    }
    
    func reloadReviews() {
        presenter.reloadReviews()
    }
}

