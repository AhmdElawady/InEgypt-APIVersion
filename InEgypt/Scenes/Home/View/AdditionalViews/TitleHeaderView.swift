//
//  TitleHeaderView.swift
//  InEgypt
//
//  Created by Awady on 9/25/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class TitleHeaderView: UICollectionReusableView {
    
    let titleLabel = HeaderTitleLabel()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .appBlue
        let deviceType = UIDevice.current.deviceSize
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addSubViews() {
        let containerStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), moreButton])
        addSubview(containerStack)
        containerStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 3)
    }
}
