//
//  HomeController.swift
//  InEgypt
//
//  Created by Awady on 4/14/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit
import CoreLocation
import SideMenu

class HomeController: BaseCollectionViewController {
    
    enum SectionTitle: String, CaseIterable {
        case topAds = "Ads"
        case attractions = "Attraction of the month"
        case spots = "Trendy Spots"
        case featured = "Featured"
        case nearby = "Around"
        case cities = "Explore Cities"
    }
    
    var presenter: HomePresenter!
    
    let locationManager = CLLocationManager()
    var menu: SideMenuNavigationController?
    var timer: Timer?
    var currentPageIndex = 0
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    var isSlideInMenuPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        
        registerCells()
        setupMenu()
        setupController()
    }
    
    private func setupMenu() {
        menu = SideMenuNavigationController(rootViewController: MenuController())
        if LocalizationManager.shared.getLanguage() == .arabic {
            SideMenuManager.default.rightMenuNavigationController = menu
            SideMenuManager.default.leftMenuNavigationController = nil
        } else {
            SideMenuManager.default.leftMenuNavigationController = menu
            SideMenuManager.default.rightMenuNavigationController = nil
        }
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu!.usingSpringWithDamping = 0.8
        menu!.presentationStyle = .viewSlideOutMenuIn
    }
    
    private func registerCells() {
        collectionView.register(TopAdsCell.self, forCellWithReuseIdentifier: "TopAdsCell")
        collectionView.register(DestinationsCell.self, forCellWithReuseIdentifier: "DestinationsCell")
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: "FeaturedCell")
        collectionView.register(HomeNearbyCell.self, forCellWithReuseIdentifier: "HomeNearbyCell")
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: "CityCell")
        collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeaderView")
        collectionView.register(NearbyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NearbyHeaderView")
    }
    
    private func setupController() {
        checkLocationServices()
        toggleTitleImage()
        setupMenuButton()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        noConnectionView.tryAgainButton.addTarget(self, action: #selector(tryAgainButtonSelected), for: .touchUpInside)
        handleSlideTimer()        
        presenter.fetchData()
//        setupRequestTripButton()
    }
    
    private func toggleTitleImage() {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        var imageName = ""
        userInterfaceStyle == .dark ? (imageName = "LogoDark") : (imageName = "LogoLight")
        let imageView = UIImageView(image: UIImage(named: imageName))
        
        imageView.anchor(widthConstant: 55)
        navigationItem.titleView = imageView
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        toggleTitleImage()
    }
        
    private func setupMenuButton() {
        let moreButton = UIBarButtonItem(image: UIImage(systemName: "text.justify")?.withTintColor(.blackToWhite).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem = moreButton
    }
    
    private func setupRequestTripButton() {
        let requestTripButton = UIBarButtonItem(image: UIImage(systemName: "airplane")?.withTintColor(.blackToWhite).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(requestTripPressed))
        navigationItem.rightBarButtonItem = requestTripButton
    }
    
    @objc private func handleMenu() {
        present(menu!, animated: true)
    }
    
    @objc private func requestTripPressed() {
//        let tripRequestController = TripRequestController()
//        navigationController?.pushViewController(tripRequestController, animated: true)
    }
    
    @objc private func pulledToRefresh() {
        reFetchingData()
        let deadline = DispatchTime.now()+1
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    // Around places by customized distance provided by user in aroundController
//    func getAroundByDistance() {
//        let distanceValue = UserDefaults.standard.float(forKey: "SliderValue")
//        aroundByDistance = around.filter { $0.distance <= Double(distanceValue) }
//        collectionView.reloadData()
//    }
    
    
    func handleSlideTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideAction), userInfo: nil, repeats: true)
    }
    @objc func slideAction() {
        if presenter.ads.isEmpty { return } // prevent crash if no data
        let selectedIndex = (currentPageIndex < presenter.ads.count - 1) ? currentPageIndex + 1 : 0
        if collectionView.contentOffset.y <= 0 {
            self.collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    private func reFetchingData() {
        presenter.fetchData()
    }
    
    @objc private func tryAgainButtonSelected() {
        reFetchingData()
        presenter.fetchData()
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }
}
