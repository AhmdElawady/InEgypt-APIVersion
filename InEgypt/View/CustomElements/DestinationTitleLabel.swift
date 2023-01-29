//
//  DestinationTitleLabel.swift
//  InEgypt
//
//  Created by Awady on 10/8/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit


class DestinationTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .white
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 22 : 14
        font = .systemFont(ofSize: fontSize, weight: .medium)
        adjustsFontSizeToFitWidth = true
    }
}
