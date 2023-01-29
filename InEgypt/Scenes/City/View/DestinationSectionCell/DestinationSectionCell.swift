//
//  AttractionSectionCell.swift
//  InEgypt
//
//  Created by Awady on 11/22/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class DestinationSectionCell: UICollectionViewCell {
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.textColor = .blackToWhite
        label.text = "Destinations".localized
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All".localized, for: .normal)
        button.setTitleColor(.appBlue, for: .normal)
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 20 : 13
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        return button
    }()
    
    let destinationsViewController = CityPlacesController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        let sectionHeaderStack = UIStackView(arrangedSubviews: [sectionLabel, UIView(), seeAllButton])
        addSubview(sectionHeaderStack)
        sectionHeaderStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 16, rightConstant: 16)
        
        addSubview(destinationsViewController.view)
        destinationsViewController.view.anchor(top: sectionHeaderStack.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
}
