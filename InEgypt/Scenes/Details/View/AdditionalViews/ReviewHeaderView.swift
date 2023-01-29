//
//  ReviewHeaderView.swift
//  InEgypt
//
//  Created by Awady on 9/28/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class ReviewHeaderView: UICollectionReusableView {
    
    let titleLabel = HeaderTitleLabel()
    
    let ratingView: FloatRatingView = {
        let ratingView = FloatRatingView()
        ratingView.emptyImage = UIImage(systemName: "star")?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        ratingView.fullImage = UIImage(systemName: "star.fill")?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        ratingView.type = .floatRatings
        ratingView.minRating = 0
        ratingView.maxRating = 5
        ratingView.editable = false
        let deviceType = UIDevice.current.deviceSize
        ratingView.anchor(widthConstant: 100, heightConstant: 20)
        return ratingView
    }()
    
    let rateCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubViews() {
        let ratingStack = UIStackView(arrangedSubviews: [ratingView, rateCountLabel])
        ratingStack.spacing = 3
        
        let containerStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), ratingStack])
        addSubview(containerStack)
        containerStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 3, rightConstant: 3)
    }
}
