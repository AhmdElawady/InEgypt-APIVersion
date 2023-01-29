//
//  ReviewCell.swift
//  InEgypt
//
//  Created by Awady on 12/23/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell, ReviewViewCell {
    
    let reviewerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .blackToWhite
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .subTitleGray
        return label
    }()
    
    let ratingView: FloatRatingView = {
        let ratingView = FloatRatingView()
        ratingView.emptyImage = UIImage(systemName: "star")?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        ratingView.fullImage = UIImage(systemName: "star.fill")?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        ratingView.type = .wholeRatings
        ratingView.minRating = 0
        ratingView.maxRating = 5
        ratingView.editable = false
        ratingView.anchor(widthConstant: 75, heightConstant: 15)
        return ratingView
    }()
    
    let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        label.numberOfLines = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondBackgroundColor
        layer.cornerRadius = 3
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        let reviewrNameStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [reviewerNameLabel, UIView(), dateLabel])
            reviewerNameLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
            stack.spacing = 10
            return stack
        }()
        
        let rateStack = UIStackView(arrangedSubviews: [ratingView, UIView()])
        
        let vStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [reviewrNameStack, rateStack, reviewTextLabel])
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        addSubview(vStack)
        vStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, topConstant: 10, leftConstant: 10, rightConstant: 10)
    }
    
    func displayReviews(review: Review) {
        reviewerNameLabel.text = review.username
        dateLabel.text = review.date
        reviewTextLabel.text = review.review
        ratingView.rating = Double(review.rate) ?? 0.0
    }
}
