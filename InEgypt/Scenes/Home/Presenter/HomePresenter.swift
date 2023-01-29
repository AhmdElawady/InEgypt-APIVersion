//
//  HomePresenter.swift
//  InEgypt
//
//  Created by Awady on 9/21/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation
import Nuke

protocol HomeView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError()
    func navigateToDetailsController(id: Int)
    func navigateToCityController(id: Int)
}

protocol AdsViewCell {
    func displaySubfeatureLabel(subFeature: String)
}

protocol HiddenGemsViewCell {
    func displayRecommended(attraction: Recommended)
    func displayTemperature(tempLabel: String)
}

protocol CategoryViewCell {
    func displayByCategory(attraction: SectionDestinations)
    func displayTemperature(tempLabel: String)
}

protocol FeatureViewCell {
    func displayFeatureCell(subFeature: Ads)
}

protocol NearbyViewCell {
    func displayAroundCell(around: HomeAround)
}

protocol CitiesViewCell {
    func displayCityLabels(city: HomeCity)
}

class HomePresenter {
    
    private weak var view: HomeView?
    private let interactor = HomeInteractor()
    
    var ads: [Ads] = []
    
    var recommendedHeader = ""
    var attractions: [Recommended] = []
    
    var categoryAttractionHeader = ""
    var categoryAttractions: [SectionDestinations] = []
    
    var featuredImage: Ads?
    
    var aroundHeader = ""
    var aroundButtonTitle = ""
    var around: [HomeAround] = []
    var aroundByDistance: [HomeAround] = []
    
    var cities: [HomeCity] = []
    
    init(view: HomeView) {
        self.view = view
    }
    
    
    func getAround(lat: String, long: String) {
        HomeInteractor.shared.fetchAround(lat: lat, long: long) { around, error in
            if error != nil { print("around error")
            } else {
                self.around = around?.data ?? []
                self.getAroundByDistance()
            }
        }
    }
    
    func getAroundByDistance() {
        let distanceValue = UserDefaults.standard.float(forKey: "SliderValue")
        aroundByDistance = around.filter { $0.distance <= Double(distanceValue) }.shuffled()
        self.view?.fetchingDataSuccess()
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        var topAds: [Ads] = []
        var homeAttraction: [Recommended] = []
        var homeCategoryAttractions: [SectionDestinations] = []
        var homeCities: [HomeCity] = []
        
        dispatchGroup.enter()
        interactor.fetchAds { ads, error in
            if error != nil { print("ads error") }
            dispatchGroup.leave()
            topAds = ads?.data ?? []
        }
        
        dispatchGroup.enter()
        interactor.fetchRecommendedAttractions { attractions, error in
            if error != nil { print("attractions error") }
            dispatchGroup.leave()
            homeAttraction = attractions?.data ?? []
        }
        
        dispatchGroup.enter()
        interactor.fetchHomeCities { cities, error in
            if error != nil { print("around error") }
            dispatchGroup.leave()
            homeCities = cities?.data ?? []
        }
        
        dispatchGroup.enter()
        let categoryId = [12:"Archeological", 4:"Historical", 16:"Mosque", 15:"Museum", 2:"Nature reserve", 14:"Palace", 8:"Nature"]
        if let randomCategory = categoryId.randomElement() {
            //                categoryTitle = randomCategory.value.localized
            let id = randomCategory.key
            SectionsService.shared.fetchCategoryPlaces(id: id) { destionations, error in
                if error != nil { print("CategoryPlaces error") }
                dispatchGroup.leave()
                homeCategoryAttractions = destionations?.data ?? []
                self.categoryAttractionHeader = "Take A Tour Of ".localized + randomCategory.value.localized
                self.recommendedHeader = "Check Out Hidden Gems".localized
            }
        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            view?.hideIndicator()
            ads = Array(topAds.prefix(7))
            featuredImage = topAds.last
            attractions = homeAttraction
            categoryAttractions = homeCategoryAttractions
            cities = homeCities
            
            view?.fetchingDataSuccess()
        }
    }
    
    func configureAds(cell: AdsViewCell, imageView: UIImageView, for index: Int) {
        let ads = ads[index]
        cell.displaySubfeatureLabel(subFeature: ads.content)
        ImageService.downloadImage(withData: ads.poster, imageView: imageView)
    }
    
    func configureHeddinGems(cell: HiddenGemsViewCell, imageView: UIImageView, for index: Int) {
        let attraction = attractions[index]
        cell.displayRecommended(attraction: attraction)
        WeatherService.shared.getTemp(latitude: attraction.latitude, longitude: attraction.longitude) { temp, error in
            let temp = temp?.current?.temp ?? 0
            let tempForm = String(format: temp == floor(temp) ? "%.0f" : "%.1f", temp) + "°C"
            DispatchQueue.main.async { cell.displayTemperature(tempLabel: tempForm) }
        }
        ImageService.downloadImage(withData: attraction.poster, imageView: imageView)
    }
    
    func configureCategory(cell: CategoryViewCell, imageView: UIImageView, for index: Int) {
        let category = categoryAttractions[index]
        cell.displayByCategory(attraction: category)
        WeatherService.shared.getTemp(latitude: category.latitude, longitude: category.longitude) { temp, error in
            let temp = temp?.current?.temp ?? 0
            let tempForm = String(format: temp == floor(temp) ? "%.0f" : "%.1f", temp) + "°C"
            DispatchQueue.main.async { cell.displayTemperature(tempLabel: tempForm) }
        }
        ImageService.downloadImage(withData: category.poster, imageView: imageView)
    }
    
    func configureFeatureImage(cell: FeatureViewCell, imageView: UIImageView) {
        guard let featuredImage = featuredImage else { return }
        cell.displayFeatureCell(subFeature: featuredImage)
        ImageService.downloadImage(withData: featuredImage.poster, imageView: imageView)
    }
    
    func configureAround(cell: NearbyViewCell, imageView: UIImageView, for index: Int) {
        let aroundItem = aroundByDistance[index]
        cell.displayAroundCell(around: aroundItem)
        ImageService.downloadImage(withData: aroundItem.poster, imageView: imageView)
    }
    
    func configureCities(cell: CitiesViewCell, imageView: UIImageView, for index: Int) {
        let city = cities[index]
        cell.displayCityLabels(city: city)
        ImageService.downloadImage(withData: city.poster, imageView: imageView)
    }
    
    func didSelectAttraction(at indexPath: IndexPath) {
        var id = Int()
        indexPath.section == 1 ? (id = attractions[indexPath.item].id) : (id = categoryAttractions[indexPath.item].id)
        view?.navigateToDetailsController(id: id)
    }
    
    func didSelectAround(at index: Int) {
        guard !aroundByDistance.isEmpty else { return }
        let id = aroundByDistance[index].id
        view?.navigateToDetailsController(id: id)
    }
    
    func didSelectCity(at index: Int) {
        view?.navigateToCityController(id: cities[index].id)
    }
}
