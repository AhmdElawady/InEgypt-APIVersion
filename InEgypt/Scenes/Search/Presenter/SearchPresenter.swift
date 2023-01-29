//
//  SearchPresenter.swift
//  InEgypt
//
//  Created by Awady on 10/2/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation
import Nuke

protocol SearchView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError()
    func navigateToCategoryController(id: Int, title: String)
    func navigateToCityController(id: Int)
    func navigateToDetailsController(id: Int)
}

protocol SearchCategoryViewCell {
    func displayCategory(category: Section)
}

protocol SearchCitiesViewCell {
    func displayCityLabels(city: CityItem)
}

protocol SearchAttractionViewCell {
    func displayAttraction(attraction: Destination)
    func displayTemperature(tempLabel: String)
}

class SearchPresenter {
    
    private weak var view: SearchView?
    
    var categories: [Section] = []
    var cities: [CityItem] = []
    var attractions: [Destination] = []
    
    init(view: SearchView) {
        self.view = view
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        var searchCategories: [Section] = []
        var searchActivities: [Section] = []
        var searchCities: [CityItem] = []
        var searchAttractions: [Destination] = []
        
        dispatchGroup.enter()
        SectionsService.shared.fetchCategory { category, error in
            if error != nil { print("Category error") }
            dispatchGroup.leave()
            searchCategories = category?.data ?? []
        }
        
        dispatchGroup.enter()
        SectionsService.shared.fetchActivity { activity, error in
            if error != nil { print("Activity error") }
            dispatchGroup.leave()
            searchActivities = activity?.data ?? []
        }
        
        dispatchGroup.enter()
        CityInteractor.shared.fetchCities { cities, error in
            if error != nil { print("City error") }
            dispatchGroup.leave()
            guard let cities = cities?.data else { return }
            searchCities = cities
        }
        
        dispatchGroup.enter()
        DestinationService.shared.fetchAttractions { results, error in
            if error != nil { print("Destination attractions error") }
            dispatchGroup.leave()
            searchAttractions = results?.data ?? []
        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            view?.hideIndicator()
            categories = searchCategories+searchActivities
            cities = searchCities
            attractions = searchAttractions.shuffled()
            
            view?.fetchingDataSuccess()
        }
    }
    
    // MARK: CollectionViewDataSource
    
    func configureCategories(cell: SearchCategoryViewCell, imageView: UIImageView, for index: Int) {
        let category = categories[index]
        cell.displayCategory(category: category)
        ImageService.downloadImage(withData: category.poster, imageView: imageView, mode: .scaleAspectFit)
    }
    
    func configureCities(cell: SearchCitiesViewCell, imageView: UIImageView, for index: Int) {
        let city = cities[index]
        cell.displayCityLabels(city: city)
        ImageService.downloadImage(withData: city.poster, imageView: imageView)
    }
    
    func configureAttractions(cell: SearchAttractionViewCell, imageView: UIImageView, for index: Int) {
        let attraction = attractions[index]
        cell.displayAttraction(attraction: attraction)
        WeatherService.shared.getTemp(latitude: attraction.latitude, longitude: attraction.longitude) { temp, error in
            let temp = temp?.current?.temp ?? 0
            let tempForm = String(format: temp == floor(temp) ? "%.0f" : "%.1f", temp) + "°C"
            DispatchQueue.main.async { cell.displayTemperature(tempLabel: tempForm) }
        }
        ImageService.downloadImage(withData: attraction.poster, imageView: imageView)
    }
    
    // MARK: CollectionViewDidSelect
    
    func didSelectCategory(at index: Int) {
        guard !categories.isEmpty else { return }
        view?.navigateToCategoryController(id: categories[index].id, title: categories[index].title)
    }
    
    func didSelectCity(at index: Int) {
        guard !cities.isEmpty else { return }
        view?.navigateToCityController(id: cities[index].id)
    }
    
    func didSelectAttraction(at index: Int) {
        guard !attractions.isEmpty else { return }
        let id = attractions[index].id
        view?.navigateToDetailsController(id: id)
    }
}
