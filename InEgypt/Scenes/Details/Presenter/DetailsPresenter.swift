//
//  DetailsPresenter.swift
//  InEgypt
//
//  Created by Awady on 9/25/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation
import Nuke

protocol DetailsView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError()
    func navigateToAboutController(title: String, description: String)
    func navigateToImageController(gallary: [ImageData], index: Int)
    func navigateToSpotController(id: Int)
    func navigateToReviewController(review: Review)
}

protocol InfoViewCell {
    func displayInfoLabels(info: Info)
}

protocol DescriptionViewCell {
    func displayDiscription(discription: String)
}

protocol MapView {
    func displayMap(map: Info)
}

protocol AttractionNearbyViewCell {
    func displayNearbyLabels(nearby: HomeAround)
}

protocol ReviewViewCell {
    func displayReviews(review: Review)
}

protocol TicketViewCell {
    func displayTicketLabels(ticket: Ticket)
}

class DetailsPresenter {
    
    private weak var view: DetailsView?
    private let interactor = DetailsInteractor()
    
    var id = Int()
    
    var info: Info?
    var gallary: [ImageData] = []
    var reviewsInfo: ReviewsInfo?
    var reviews: [Review] = []
    var nearby: [HomeAround] = []
    //    var categories: [PlaceSection] = []
    var isLiked: Bool = false
    
    init(view: DetailsView, id: Int) {
        self.view = view
        self.id = id
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        var detailsInfo: Info?
        var detailsGallary: [ImageData] = []
        var detailsReviewInfo: ReviewsInfo?
        var detailsReviews: [Review] = []
        
        
        dispatchGroup.enter()
        DetailsInteractor.shared.fetchInfo(id: id) { info, error in
            if error != nil { print("Details info error") }
            dispatchGroup.leave()
            detailsInfo = info?.data
        }
        
        dispatchGroup.enter()
        DetailsInteractor.shared.fetchGallary(id: id) { gallary, error in
            if error != nil { print("Details gallary error") }
            dispatchGroup.leave()
            detailsGallary = gallary?.data ?? []
        }
        
        dispatchGroup.enter()
        DetailsInteractor.shared.fetchReviews(id: id) { reviewsInfo, error in
            if error != nil { print("Details Reviews error") }
            dispatchGroup.leave()
            detailsReviewInfo = reviewsInfo?.data
            detailsReviews = reviewsInfo?.data.review ?? []
        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            view?.hideIndicator()
            info = detailsInfo
            fetchAround(lat: detailsInfo?.latitude ?? "", long: detailsInfo?.longitude ?? "")
            gallary = detailsGallary
            reviewsInfo = detailsReviewInfo
            reviews = detailsReviews
            view?.fetchingDataSuccess()
        }
    }
    
    func fetchAround(lat: String, long: String) {
        HomeInteractor.shared.fetchAround(lat: lat, long: long) { nearby, error in
            if error != nil { print("around error") }
            let nearbyItems = nearby?.data ?? []
            self.nearby = nearbyItems.filter { $0.distance <= Double(5.00) && $0.distance > Double(0.001) }.shuffled()
            self.view?.fetchingDataSuccess()
        }
        
    }
    
    func displayPoster(imageView: UIImageView) {
        if let info { ImageService.downloadImage(withData: info.poster, imageView: imageView) }
    }
    
    func configureInfo(cell: InfoViewCell) {
        if let info { cell.displayInfoLabels(info: info) }
    }
    
    func configureDescription(cell: DescriptionViewCell) {
        if let info { cell.displayDiscription(discription: info.description) }
    }
    
    func configureGallary(imageView: UIImageView, for index: Int) {
        let image = gallary[index].image
        ImageService.downloadImage(withData: image, imageView: imageView)
    }
    
    func configureMap(view: MapView) {
        if let info { view.displayMap(map: info) }
    }
    
    func configureNearby(cell: AttractionNearbyViewCell, imageView: UIImageView, for index: Int) {
        let nearbyItem = nearby[index]
        cell.displayNearbyLabels(nearby: nearbyItem)
        ImageService.downloadImage(withData: nearbyItem.poster, imageView: imageView)
    }
    
    func configureReview(cell: ReviewViewCell, for index: Int) {
        let review = reviews[index]
        cell.displayReviews(review: review)
    }
    
    func configureTicket(cell: TicketViewCell) {
        if let ticket = info?.ticketsPrice { cell.displayTicketLabels(ticket: ticket) }
    }
    
    func didSelectAbout() {
        guard info != nil else { return }
        let title = info?.title ?? ""
        let description = info?.description ?? ""
        view?.navigateToAboutController(title: title, description: description)
    }
    
    func didSelectImage(at index: Int) {
        if !gallary.isEmpty {
            view?.navigateToImageController(gallary: gallary, index: index)
        }
    }
    
    func didSelectNearby(at index: Int) {
        if !nearby.isEmpty {
            let id = nearby[index].id
            view?.navigateToSpotController(id: id)
        }
    }
    
    func didSelectReview(at index: Int) {
        if !reviews.isEmpty {
            let review = reviews[index]
            view?.navigateToReviewController(review: review)
        }
    }
    
    func reloadReviews() {
        DetailsInteractor.shared.fetchReviews(id: id) { reviewsInfo, error in
            self.view?.hideIndicator()
            if error != nil { print("Details Reviews error") }
            self.reviewsInfo = reviewsInfo?.data
            self.reviews = reviewsInfo?.data.review ?? []
            self.view?.fetchingDataSuccess()
        }
    }
}
