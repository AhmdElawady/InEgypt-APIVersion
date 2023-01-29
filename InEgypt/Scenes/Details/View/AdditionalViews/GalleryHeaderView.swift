//
//  GalleryHeaderView.swift
//  InEgypt
//
//  Created by Awady on 9/28/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class GalleryHeaderView: UICollectionReusableView {
    
    let titleLabel = HeaderTitleLabel()
    
    let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .appBlue
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .medium)
        let btnImage = UIImage(systemName: "rectangle.3.group", withConfiguration: imageConfigration)
        let tintedImage = btnImage?.withRenderingMode(.alwaysOriginal).withTintColor(.appBlue)
        button.setImage(tintedImage, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubViews() {
        let containerStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), galleryButton])
        addSubview(containerStack)
        containerStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 3)
    }
}
