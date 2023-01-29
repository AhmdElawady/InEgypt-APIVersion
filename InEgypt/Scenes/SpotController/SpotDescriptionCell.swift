//
//  SpotInfoCell.swift
//  InEgypt
//
//  Created by Awady on 8/24/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

//import UIKit
//
//class SpotDescriptionCell: UICollectionViewCell {
//    
//    let aboutLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .valueTextColor
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupSubViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return aboutLabel.sizeThatFits(size)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        aboutLabel.sizeToFit()
//    }
//
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        return sizeThatFits(targetSize)
//    }
//    
//    private func setupSubViews() {
//        addSubview(aboutLabel)
//        aboutLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
//    }
//}
