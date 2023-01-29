//
//  SearchCategoryCell.swift
//  InEgypt
//
//  Created by Awady on 9/5/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class SearchCategoryCell: UICollectionViewCell, SearchCategoryViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .subTitleGray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .iconBackgroundGray
        layer.cornerRadius = 10
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 5
            stackView.axis = .vertical
            return stackView
        }()
        
        addSubview(stackView)
        layoutIfNeeded()
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5)
    }
    
    func displayCategory(category: Section) {
        titleLabel.text = category.title
    }
}

