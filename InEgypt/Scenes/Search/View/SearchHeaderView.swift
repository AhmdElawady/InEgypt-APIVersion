//
//  SearchHeaderView.swift
//  InEgypt
//
//  Created by Awady on 9/5/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class SearchHeaderView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 3)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
