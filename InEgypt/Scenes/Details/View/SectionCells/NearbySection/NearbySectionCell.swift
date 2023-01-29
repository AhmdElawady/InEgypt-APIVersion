//
//  NearbySectionCell.swift
//  InEgypt
//
//  Created by Awady on 8/21/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class NearbySectionCell: UICollectionViewCell, AttractionNearbyViewCell {
    
    let spotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.text = ""
        return label
    }()
    
    
    let distanceIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")
        imageView.anchor(widthConstant: 18, heightConstant: 18)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .subTitleGray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 23, weight: .light, scale: .small)
        return imageView
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        let distanceStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [distanceIcon, distanceLabel])
            stack.spacing = 2
            stack.axis = .horizontal
            return stack
        }()
        
        let distanceCategoryStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [distanceStack, UIView(), categoryLabel])
            stack.axis = .horizontal
            return stack
        }()
        
        let labelsStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleLabel, distanceCategoryStack])
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        let containerStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [spotImageView, labelsStack])
            stack.axis = .horizontal
            stack.spacing = 7
            stack.alignment = .center
            return stack
        }()
        
        addSubview(containerStack)
        containerStack.anchorCenterYToSuperview()
        containerStack.anchor(leading: leadingAnchor, trailing: trailingAnchor, leftConstant: 0, rightConstant: 0)
    }
    
    func displayNearbyLabels(nearby: HomeAround) {
        titleLabel.text = nearby.name
//        categoryLabel.text = data.category
        distanceLabel.text = String(format: "%.2f", nearby.distance)+" km".localized
    }
}
