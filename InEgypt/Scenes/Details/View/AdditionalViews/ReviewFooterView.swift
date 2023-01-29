//
//  ReviewFooterView.swift
//  InEgypt
//
//  Created by Awady on 9/28/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class ReviewFooterView: UICollectionReusableView {
    
    let addReviewButton: UIButton = {
        let button = UIButton(type: .system)
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 18
        button.setTitle("ADD A REVIEW".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appBlue.cgColor
        button.backgroundColor = .backgroundColor
        button.tintColor = .appBlue
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubViews() {
        addSubview(addReviewButton)
        addReviewButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 5, leftConstant: 3, bottomConstant: 0, rightConstant: 3)
    }
}
