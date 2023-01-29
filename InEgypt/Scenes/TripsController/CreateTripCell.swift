//
//  CreateTripCell.swift
//  InEgypt
//
//  Created by Awady on 4/1/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CreateTripCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.9439096932, green: 0.9439096932, blue: 0.9439096932, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "Ramsees II")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.text = "CREATE A TRIP"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Choose your visits, fill requested fields and send us the information. Shortly we will contact with you"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(containerView)
        containerView.addSubview(backgroundImage)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(titleLabel)
        
        backgroundImage.fillSuperview()
        titleLabel.anchorCenterSuperview()
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 5, rightConstant: 10)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
    }
}
