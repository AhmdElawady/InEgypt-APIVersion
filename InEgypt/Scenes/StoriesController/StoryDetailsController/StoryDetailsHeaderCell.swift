//
//  StunningDetailsHeaderCell.swift
//  InEgypt
//
//  Created by Awady on 11/26/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class StoryDetailsHeaderCell: UITableViewCell {
    
    let storyCell = StoryCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .medium)
        let image = UIImage(named: "lightOnDark", in: nil, with: imageConfigration)
        let tintedImage = image?.withRenderingMode(.alwaysOriginal)
        button.setImage(tintedImage, for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        storyCell.layer.cornerRadius = 0
//        storyCell.categoryLabel.numberOfLines = 0
        addSubview(storyCell)
        storyCell.fillSuperview()
        contentView.addSubview(closeButton)
        closeButton.anchor(top: contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 30, heightConstant: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
