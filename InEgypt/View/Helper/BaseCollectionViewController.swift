//
//  BaseCollectionViewController.swift
//  InEgypt
//
//  Created by Awady on 5/27/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit
import Network
import Connectivity

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() { super.init(collectionViewLayout: UICollectionViewFlowLayout()) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let isActiveKey = Notification.Name(rawValue: "connected")
    let notActiveKey = Notification.Name(rawValue: "notConnected")
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let deviceType = UIDevice.current.deviceSize
        let style: UIActivityIndicatorView.Style = deviceType == .iPad ? .large : .medium
        let indecator = UIActivityIndicatorView(style: style)
        indecator.color = .systemGray
        indecator.startAnimating()
        indecator.hidesWhenStopped = true
//        indecator.backgroundColor = .nightViewColor
        return indecator
    }()
    
    let noConnectionView = NoConnectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchorCenterSuperview()
        setupNavigationBar()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .backgroundColor
        setupNoConnectionView()
    }
    
    func transitionAnimation(direction: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        collectionView.layer.add(transition, forKey: kCATransition)
    }
    
    private func setupNoConnectionView() {
        NetworkMonitor.shared.setupConnectivityView(noConnectionView: noConnectionView, currentView: view)
    }
}
