//
//  AboutSectionCell.swift
//  InEgypt
//
//  Created by Awady on 12/21/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class AboutSectionCell: UICollectionViewCell, DescriptionViewCell {
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        label.numberOfLines = 6
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(aboutLabel)
        aboutLabel.fillSuperview()
    }
    
    func displayDiscription(discription: String) {
        aboutLabel.text = discription
    }
}
