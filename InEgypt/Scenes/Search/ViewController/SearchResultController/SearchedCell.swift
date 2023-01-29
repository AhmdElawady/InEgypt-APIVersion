//
//  SearchedCell.swift
//  InEgypt
//
//  Created by Awady on 1/30/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class SearchedCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = .blackToWhite
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .subTitleGray
        return label
    }()

    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.textColor = .subTitleGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backgroundColor
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let titleStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleLabel, UIView(), categoryLabel])
            stack.axis = .horizontal
            return stack
        }()

        let containerStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleStack, cityLabel])
            stack.axis = .vertical
            stack.spacing = 3
            return stack
        }()
        
        addSubview(containerStack)
        containerStack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 6, leftConstant: 20, bottomConstant: 6, rightConstant: 20)
    }
    
    func configureDestination(data: Search) {
        titleLabel.text = data.name
        cityLabel.text = data.city
        categoryLabel.text = data.category
    }
}
