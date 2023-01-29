//
//  NearbyController.swift
//  InEgypt
//
//  Created by Awady on 3/26/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel


class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
//        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.40, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 70.0, edge: .bottom, referenceGuide: .safeArea),
    ]
}

class NearbyController: UIViewController, FloatingPanelControllerDelegate, SliderDelegate {
    
    lazy var centerMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(centerMapButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var nearbyThisAreaButton: LoadingUIButton = {
        let button = LoadingUIButton(type: .system)
        button.layer.cornerRadius = 3
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .medium)
        let btnImage = UIImage(systemName: "scope", withConfiguration: imageConfigration)?.imageFlippedForRightToLeftLayoutDirection()
        let tintedImage = btnImage?.withRenderingMode(.alwaysOriginal).withTintColor(.appBlue)
        button.setImage(tintedImage, for: .normal)
        button.indicatorColor = .blackToWhite
        button.addTarget(self, action: #selector(nearbyThisAreaPressed), for: .touchUpInside)
        return button
    }()
    
    let nearbyPanelController = NearbyPanelController()
    var presenter: NearbyPresenter!
    var mapView = MKMapView()
    var currentMapRegion = CLLocationCoordinate2D()
    var selectedMapRegion = CLLocationCoordinate2D()
    var sliderValue = Float()
    
    var filteredDestinations: [HomeAround] = []
    
    let locationManager = CLLocationManager()
    let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["All".localized, "Attractions".localized, "Spots".localized])
        segmented.selectedSegmentIndex = 0
        return segmented
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NearbyPresenter(view: self)
        
        setupNavigationBar()
        setupController()
        setupLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    private func setupController() {
        navigationItem.titleView = segmentedControl
        segmentedControl.addTarget(self, action: #selector(handleSegmentedSelection), for: .valueChanged)
        addSubViews()
        setupMapView()
        setupFloatingPanel()
        let value = UserDefaults.standard.float(forKey: "SliderValue")
        sliderValue = value
//        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func setupFloatingPanel() {
        var floatingPanel = FloatingPanelController()
        floatingPanel.delegate = self
        nearbyPanelController.sliderDelegate = self
        
        floatingPanel.set(contentViewController: nearbyPanelController)
        floatingPanel.addPanel(toParent: self)
        
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 16
        shadow.spread = 8
        appearance.shadows = [shadow]
        appearance.cornerRadius = 10
        appearance.backgroundColor = .backgroundColor.withAlphaComponent(0.9)
        floatingPanel.surfaceView.appearance = appearance
        floatingPanel = FloatingPanelController(delegate: self)
        floatingPanel.layout = MyFloatingPanelLayout()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return MyFloatingPanelLayout()
    }
    
    private func addSubViews() {
        view.addSubview(mapView)
        mapView.fillSuperview()
        
        let buttonsStack: UIStackView = {
            let separator = UIView()
            separator.anchor(heightConstant: 1)
            separator.backgroundColor = .systemGray2
            let stackView = UIStackView(arrangedSubviews: [centerMapButton, separator, nearbyThisAreaButton])
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 10
            return stackView
        }()
        
        let stackContainer: UIView = {
            let view = UIView()
            view.backgroundColor = .whiteToBlack.withAlphaComponent(0.6)
            view.layer.cornerRadius = 5
            return view
        }()
        
        stackContainer.addSubview(buttonsStack)
        buttonsStack.anchor(top: stackContainer.topAnchor, left: stackContainer.leftAnchor, bottom: stackContainer.bottomAnchor, right: stackContainer.rightAnchor, topConstant: 10, leftConstant: 4, bottomConstant: 10, rightConstant: 4)
        
        mapView.addSubview(stackContainer)
        stackContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, trailing: mapView.trailingAnchor, topConstant: 10, rightConstant: 10, widthConstant: 40)
    }
    
    private func setupMapView() {
        mapView.delegate = self
//        mapView.isPitchEnabled = true
        mapView.showsScale = true
        mapView.isRotateEnabled = false
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 6500000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        let centerEgyptLocation = CLLocationCoordinate2D(latitude: 26.8206, longitude: 30.8025)
        let boundryRegion = MKCoordinateRegion(center: centerEgyptLocation, latitudinalMeters: 1200000, longitudinalMeters: 1200000)
        mapView.setRegion(boundryRegion, animated: true)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: boundryRegion), animated: true)
        
        currentMapRegion = centerEgyptLocation
        selectedMapRegion = centerEgyptLocation
    }
    
    func sliderEndMove(value: Float) {
        sliderValue = value
        addAroundAnnotationsWithRadius()
        centerViewOnMapFromRegion(centerRegion: selectedMapRegion)
    }
    
    @objc private func handleSegmentedSelection() {
        addAroundAnnotationsWithRadius()
        transitionAnimation(direction: .fromRight)
    }
    
    @objc private func centerMapButtonPressed() {
        var authorizationStatus: CLAuthorizationStatus?
        
        if #available(iOS 14.0, *) { authorizationStatus = locationManager.authorizationStatus
        } else { authorizationStatus = CLLocationManager.authorizationStatus() }
        
        switch authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            mapView.showsUserLocation = true
//            fetchNearbyUserLocation()
            initialCenterViewOnUserLocation()
            break
        case .denied:
            askToOpenLocationWithAction()
            addAllAnnotations()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            addAllAnnotations()
            break
        case .restricted:
            askToOpenLocationWithAction()
            addAllAnnotations()
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            initialCenterViewOnUserLocation()
            break
        case .none:
            break
        @unknown default:
            break
        }
    }
    
    private func askToOpenLocationWithAction() {
        Alert.locationDisabledAlert(on: self)
    }
    
    @objc private func nearbyThisAreaPressed() {
        fetchNearbyMapRegion()
        nearbyThisAreaButton.isEnabled = false
        nearbyThisAreaButton.alpha = 0.4
        centerViewOnMapFromRegion(centerRegion: currentMapRegion)
        selectedMapRegion = mapView.centerCoordinate
        segmentedControl.selectedSegmentIndex = 0
    }
    
    internal func setCenterButtonImage(imageName: String) {
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .medium)
        let btnImage = UIImage(systemName: imageName, withConfiguration: imageConfigration)?.imageFlippedForRightToLeftLayoutDirection()
        let tintedImage = btnImage?.withRenderingMode(.alwaysOriginal).withTintColor(.appBlue)
        centerMapButton.setImage(tintedImage, for: .normal)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        setCenterButtonImage(imageName: "location")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newMapRegion = mapView.centerCoordinate
        let latRange = abs(selectedMapRegion.latitude-newMapRegion.latitude)
        let longRange = abs(selectedMapRegion.longitude-newMapRegion.longitude)
        
        if let userLocation = locationManager.location?.coordinate {
            let fromUserLatRang = abs(userLocation.latitude-newMapRegion.latitude)
            let fromUserLongRang = abs(userLocation.longitude-newMapRegion.longitude)
            if fromUserLatRang <= 0.03 && fromUserLongRang <= 0.03 {
                nearbyThisAreaButton.isEnabled = false
                nearbyThisAreaButton.alpha = 0.3
            }
        }

        if latRange <= 0.2 && longRange <= 0.2 {
            nearbyThisAreaButton.isEnabled = false
            nearbyThisAreaButton.alpha = 0.3
        } else {
            nearbyThisAreaButton.isEnabled = true
            nearbyThisAreaButton.alpha = 1.0
        }
        currentMapRegion = mapView.centerCoordinate
    }
    
    private func transitionAnimation(direction: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        nearbyPanelController.collectionView.layer.add(transition, forKey: kCATransition)
    }
    
    internal func fetchNearbyUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let userLatitude = "\(userLocation.latitude)"
        let userLongitude = "\(userLocation.longitude)"
        presenter.fetchNearby(userLatitude: userLatitude, userLongitude: userLongitude)
    }
    
    internal func fetchNearbyMapRegion() {
        let latitude = "\(currentMapRegion.latitude)"
        let longitude = "\(currentMapRegion.longitude)"
        presenter.fetchAreaNearby(userLatitude: latitude, userLongitude: longitude)
    }
    
    private func centerViewOnMapFromRegion(centerRegion: CLLocationCoordinate2D) {
        let radius = Double(sliderValue * 1000)
        let region = MKCoordinateRegion.init(center: centerRegion, latitudinalMeters: radius*2, longitudinalMeters: radius*2)
        mapView.setRegion(region, animated: true)
        showCircle(coordinate: centerRegion, radius: radius)
    }
}
