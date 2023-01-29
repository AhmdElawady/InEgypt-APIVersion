//
//  NetworkMonitor.swift
//  InEgypt
//
//  Created by Awady on 9/11/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Network
import Connectivity

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    let connectivity = Connectivity()
    
    private static var notifyWhenLaunch: Bool = false
    private let connectivityChanged: ((Connectivity) -> Void) = { connectivity in
        updateConnectionStatus(connectivity.status)
    }

    init() {}
    
    private static func updateConnectionStatus(_ status: Connectivity.Status) {
        
        switch status {
        case .connectedViaWiFi, .connectedViaCellular, .connected:
            if notifyWhenLaunch {
                Banner.connectionBanner(message: status.description.localized, backgroundColor: #colorLiteral(red: 0.1253990531, green: 0.7744275928, blue: 0.6015858054, alpha: 0.8047651076))
            } else { notifyWhenLaunch = true }
            break
        case .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet, .notConnected:
            Banner.connectionBanner(message: status.description.localized, backgroundColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 0.8047392384))
            notifyWhenLaunch = true
            break
        case .determining:
            break
        }
    }
    
    func setupNotifier() {
        connectivity.framework = .network
        connectivity.isPollingEnabled = true
        connectivity.pollWhileOfflineOnly = true
        connectivity.pollingInterval = 10
        connectivity.whenDisconnected = connectivityChanged
        connectivity.whenConnected = connectivityChanged
        connectivity.startNotifier()
    }
    
    func setupConnectivityView(noConnectionView: UIView, currentView: UIView) {
//        if connectivity.isConnected {
//            noConnectionView.removeFromSuperview()
//        } else {
//            currentView.addSubview(noConnectionView)
//            noConnectionView.frame = currentView.bounds
//            Banner.connectionBanner(message: connectivity.status.description.localized, backgroundColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 0.8047392384))
//        }
        let status = connectivity.status
        switch status {
        case .connectedViaWiFi, .connectedViaCellular, .connected:
            noConnectionView.removeFromSuperview()
            break
        case .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet, .notConnected:
            currentView.addSubview(noConnectionView)
            noConnectionView.frame = currentView.bounds
            Banner.connectionBanner(message: "Something wrong with network connection".localized, backgroundColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 0.8047392384))
            break
        case .determining:
            break
        }
        
    }
    
//    func performSingleConnectivityCheck() {
//        connectivity.checkConnectivity { connectivity in
//            self.updateSingleConnectionStatus(connectivity.status)
//        }
//    }
}
