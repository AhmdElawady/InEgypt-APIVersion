//
//  ReviewController.swift
//  InEgypt
//
//  Created by Awady on 12/31/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class ReviewController: UIViewController {
    
    let ReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Ratings & Reviews".localized
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .blackToWhite
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let btnImage = UIImage(systemName: "xmark")
        let tintedImage = btnImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .appBlue
        button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 3
        return view
    }()
    
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
        label.numberOfLines = 0
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        return scrollView
    }()
    
    let reviewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .secondBackgroundColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupViews()
    }
    
    private func setupViews() {
        
        let topStackView = UIStackView(arrangedSubviews: [ReviewLabel, UIView(), dismissButton])
        
        let reviewerNameStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [reviewerNameLabel, UIView(), dateLabel])
            reviewerNameLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
            stack.axis = .horizontal
            stack.spacing = 5
            return stack
        }()
        
        let rateStack = UIStackView(arrangedSubviews: [ratingView, UIView()])
        
        let reviewStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [reviewerNameStack, rateStack, reviewTextLabel])
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        reviewContainer.addSubview(reviewStack)
        reviewStack.anchor(top: reviewContainer.topAnchor, leading: reviewContainer.leadingAnchor, bottom: reviewContainer.bottomAnchor, trailing: reviewContainer.trailingAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
        
        let vStack: UIStackView = {
           let stack = UIStackView(arrangedSubviews: [topStackView, separatorView])
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        view.addSubview(vStack)
        vStack.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, topConstant: 30, leftConstant: 10, rightConstant: 10)
        
        scrollView.addSubview(reviewContainer)
        reviewContainer.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: view.frame.width - 20)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: vStack.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureReview(review: Review) {
        reviewerNameLabel.text = review.username
        dateLabel.text = review.date
        ratingView.rating = Double(review.rate) ?? 0.0
        reviewTextLabel.text = review.review
    }
}
