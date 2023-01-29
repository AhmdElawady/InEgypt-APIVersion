//
//  ReviewBackgroundView.swift
//  InEgypt
//
//  Created by Awady on 10/6/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class ReviewBackgroundView: UICollectionReusableView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let indecator = UIActivityIndicatorView(style: .medium)
        indecator.color = .systemGray
        indecator.startAnimating()
        indecator.hidesWhenStopped = true
        return indecator
    }()
    
    let placeholderTitle: UILabel = {
        let label = UILabel()
        label.text = "No Reviews!".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .subTitleGray
        label.textAlignment = .center
        return label
    }()
    
    let placeholderSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Help the community and share your thoughts".localized
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .subTitleGray
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let placeholderImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noComment"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var placeholderStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let deviceType = UIDevice.current.deviceSize
        let bottomConstant: CGFloat = deviceType == .iPad ? 80 : 40 // depend on button height
        placeholderStack = UIStackView(arrangedSubviews: [placeholderImage, placeholderTitle, placeholderSubtitle])
        placeholderStack.axis = .vertical
        placeholderStack.spacing = 5
        addSubview(placeholderStack)
        
        placeholderStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 25, leftConstant: 0, bottomConstant: bottomConstant+25, rightConstant: 0)
    }
}
