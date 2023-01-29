//
//  CityPresenter.swift
//  InEgypt
//
//  Created by Awady on 10/7/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation
import Nuke

protocol CityView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError()
    func navigateToDetailsController(id: Int)
}

protocol CityViewHeader {
    func displayInfo(cityInfo: City)
    func displayTemperature(tempLabel: String)
}

class CityPresenter {
    
    private weak var view: CityView?
    private let interactor = CityInteractor()
    
    var id = Int()
    var cityInfo: City?

    init(view: CityView, id: Int) {
        self.view = view
        self.id = id
    }
    
    func fetchCityInfo() {
        CityInteractor.shared.fetchCity(id: id) { city, error in
            if error != nil { print("City error") }
            self.view?.hideIndicator()
            guard let city = city?.data else { return }
            self.cityInfo = city
            DispatchQueue.main.async {
                self.view?.fetchingDataSuccess()
            }
        }
    }
    
    func configureInfo(cell: CityViewHeader, imageView: UIImageView) {
        if let cityInfo {
            cell.displayInfo(cityInfo: cityInfo)
            WeatherService.shared.getTemp(latitude: cityInfo.latitude, longitude: cityInfo.longitude) { temp, error in
                let temp = temp?.current?.temp ?? 0
                let tempForm = String(format: temp == floor(temp) ? "%.0f" : "%.1f", temp) + "°C"
                DispatchQueue.main.async { cell.displayTemperature(tempLabel: tempForm) }
            }
            ImageService.downloadImage(withData: cityInfo.poster, imageView: imageView)
        }
    }
}
