//
//  DetailsTitleHeaderView.swift
//  InEgypt
//
//  Created by Awady on 4/25/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class DetailsTitleHeaderView: UICollectionReusableView {
    
    let titleLabel = HeaderTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addSubViews() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor)
    }
}
