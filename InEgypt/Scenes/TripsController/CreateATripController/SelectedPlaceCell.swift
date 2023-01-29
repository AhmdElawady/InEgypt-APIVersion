//
//  SelectedPlaceCell.swift
//  InEgypt
//
//  Created by Awady on 4/9/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class SelectedPlaceCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium, scale: .medium)
        let btnImage = UIImage(systemName: "xmark", withConfiguration: imageConfigration)
        let tintedImage = btnImage?.withRenderingMode(.alwaysOriginal).withTintColor(.subTitleGray)
        button.setImage(tintedImage, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        layer.cornerRadius = 7
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        addSubViews()
    }
    
    private func addSubViews() {
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, closeButton])
            stackView.spacing = 5
            stackView.axis = .horizontal
            return stackView
        }()
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, heightConstant: 30)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
