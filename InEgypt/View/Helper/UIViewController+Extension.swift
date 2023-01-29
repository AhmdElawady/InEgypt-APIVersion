//
//  UIViewController+Extension.swift
//  InEgypt
//
//  Created by Awady on 5/16/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

extension UIViewController {
  
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .backgroundColor
        navigationController?.navigationBar.tintColor = .appBlue
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.sizeToFit()
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"".localized, style:.plain, target:nil, action:nil)
        view.backgroundColor = .backgroundColor
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.hidesBarsOnSwipe = true
    }
    
    
//
//    func handleNetworkConnection() {
//
//        let config = URLSessionConfiguration.default
//        config.allowsExpensiveNetworkAccess = false
//        config.allowsConstrainedNetworkAccess = false
//        config.waitsForConnectivity = true
//        config.requestCachePolicy = .returnCacheDataElseLoad
//    }
    

}
