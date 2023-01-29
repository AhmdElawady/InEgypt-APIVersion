//
//  Banner.swift
//  InEgypt
//
//  Created by Awady on 10/25/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit
import SwiftMessages

class Banner {
    
    static func basicBannerView(title: String, message: String, iconText: String) {
        let bannerView = MessageView.viewFromNib(layout: .statusLine)
        bannerView.configureTheme(.info)
        bannerView.configureDropShadow()
        bannerView.configureContent(title: title, body: message, iconText: iconText)
        bannerView.backgroundColor = .appBlue.withAlphaComponent(0.8)
        bannerView.bodyLabel?.textColor = .white
        bannerView.bodyLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        bannerView.bodyLabel?.textAlignment = .natural
        bannerView.bodyLabel?.sizeToFit()
        bannerView.bodyLabel?.isHidden = false
        bannerView.titleLabel?.isHidden = true
        bannerView.iconLabel?.isHidden = true
        bannerView.button?.isHidden = true

        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .seconds(seconds: 2)
        config.dimMode = .none
        config.interactiveHide = true
  
        SwiftMessages.show(config: config, view: bannerView)
    }
    
    static func connectionBanner(message: String, backgroundColor: UIColor) {
        let bannerView = MessageView.viewFromNib(layout: .statusLine)
        bannerView.configureTheme(.info)
        bannerView.configureContent(title: "", body: message, iconText: "wifi.slash")
        bannerView.backgroundColor = backgroundColor
        bannerView.bodyLabel?.textColor = .white
        bannerView.bodyLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        bannerView.bodyLabel?.textAlignment = .natural
        bannerView.bodyLabel?.sizeToFit()
        bannerView.titleLabel?.isHidden = true
        bannerView.iconLabel?.isHidden = true
        bannerView.button?.isHidden = true
        bannerView.bodyLabel?.isHidden = false
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .seconds(seconds: 2)
        config.dimMode = .none
        config.interactiveHide = true
        
        SwiftMessages.show(config: config, view: bannerView)
    }
    
}
