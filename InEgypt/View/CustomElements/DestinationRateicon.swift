//
//  DestinationRateicon.swift
//  InEgypt
//
//  Created by Awady on 10/8/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class DestinationRateicon: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.image = UIImage(systemName: "star.fill")
        let deviceType = UIDevice.current.deviceSize
        let size: CGFloat = deviceType == .iPad ? 25 : 18
        anchor(widthConstant: size, heightConstant: size)
        contentMode = .scaleAspectFit
        tintColor = .appYellow
        preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .small)
    }
}
