//
//  NoConnectionView.swift
//  InEgypt
//
//  Created by Awady on 10/29/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class NoConnectionView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteToBlack
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 80, weight: .regular, scale: .large)
        let image = UIImage(systemName: "wifi.slash", withConfiguration: imageConfigration)
        let imageView = UIImageView(image: image?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray))
        imageView.contentMode = .center
        return imageView
    }()
    
    let tryAgainButton: LoadingUIButton = {
        let button = LoadingUIButton(type: .system)
        button.setTitle("Try again".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.tintColor = .appBlue
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        label.text = "No internet connection".localized
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let labelTryAgainStack = UIStackView(arrangedSubviews: [descriptionLabel, tryAgainButton])
        labelTryAgainStack.spacing = 15
        labelTryAgainStack.axis = .vertical
        labelTryAgainStack.alignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [iconImageView, labelTryAgainStack])
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 20
        
        containerView.addSubview(containerStack)
        containerStack.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
        
        addSubview(containerView)
        containerView.anchor(leading: leadingAnchor, trailing: trailingAnchor, leftConstant: 20, rightConstant: 20, heightConstant: 300)
        containerView.anchorCenterSuperview()
    }
}
