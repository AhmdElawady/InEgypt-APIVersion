//
//  UILabelExtension.swift
//  InEgypt
//
//  Created by Awady on 10/8/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class WeatherLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .white
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 2.5)
        layer.masksToBounds = false
        
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        font = .systemFont(ofSize: fontSize, weight: .regular)
    }
}
