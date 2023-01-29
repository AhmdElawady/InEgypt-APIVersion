//
//  DestinationSubTitleIcon.swift
//  InEgypt
//
//  Created by Awady on 10/8/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit


class DestinationSubTitleIcon: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let image = UIImage(systemName: "location.fill")?.imageFlippedForRightToLeftLayoutDirection()
        self.image = image
        contentMode = .scaleAspectFit
        tintColor = .white
        let deviceType = UIDevice.current.deviceSize
        let pointSize: CGFloat = deviceType == .iPad ? 22 : 10
        preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .light, scale: .small)
        let size: CGFloat = deviceType == .iPad ? 23 : 13
        anchor(widthConstant: size, heightConstant: size)
    }
}
