//
//  NearbyHeaderView.swift
//  InEgypt
//
//  Created by Awady on 10/6/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class NearbyHeaderView: UICollectionReusableView {
    
    let titleLabel = HeaderTitleLabel()
    
    let nearbyIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let image = UIImage(systemName: "location.circle")?.imageFlippedForRightToLeftLayoutDirection()
        let customizedImage = image?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        imageView.image = customizedImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let customButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Custom".localized, for: .normal)
        button.tintColor = .appBlue
        let deviceType = UIDevice.current.deviceSize
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Nearby".localized
        backgroundColor = .backgroundColor
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addSubViews() {
        let titleStack = UIStackView(arrangedSubviews: [nearbyIcon, titleLabel])
        titleStack.spacing = 5
        
        let containerStack = UIStackView(arrangedSubviews: [titleStack, UIView(), customButton])
        addSubview(containerStack)
        containerStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 3)
    }
}
