//
//  StunningCell.swift
//  InEgypt
//
//  Created by Awady on 11/24/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    var storyItem: Story! {
        didSet {
            categoryLabel.text = storyItem.category
            titleLabel.text = storyItem.title
            imageView.image = storyItem.image
//            descriptionLabel.text = storyItem.description
        }
    }
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Tut"))
    
    let categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "Archeological"
        label.textColor = .darkGray
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Tut Ankh Amon"
        
        return label
    }()
    
    let labelsContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
//        view.layer.cornerRadius = 16
        
        return view
    }()
    
//    let descriptionLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.font = .systemFont(ofSize: 16, weight: .bold)
//        label.text = "The little golden king The little golden king, The little golden king, The little golden king, The little golden king"
//        label.numberOfLines = 3
//        return label
//    }()
    
    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        imageView.fillSuperview()
        addLabels()
        
//        let labelsStack: UIStackView = {
//            let stack = UIStackView(arrangedSubviews: [titleLabel, categoryLabel])
//            stack.axis = .vertical
//            stack.spacing = 5
//            stack.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9)
//            return stack
//        }()
//
//        addSubview(labelsStack)
//        labelsStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
        
        
//        imageView.fillSuperview()
        
//        let imageContainerView = UIView()
//        imageContainerView.addSubview(imageView)
//        imageView.anchor(widthConstant: 200, heightConstant: 200)
//        imageView.anchorCenterSuperview()
        
//        let containerStack: UIStackView = {
//            let stack = UIStackView(arrangedSubviews: [labelsStack, imageContainerView])
//            stack.spacing = 8
//            stack.axis = .vertical
//            return stack
//        }()
//
//        addSubview(containerStack)
//        containerStack.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 24, leftConstant: 24, bottomConstant: 24, rightConstant: 24)
        
    }
    
    private func addLabels() {
        labelsContainer.addSubview(titleLabel)
        titleLabel.anchor(top: labelsContainer.topAnchor, left: labelsContainer.leftAnchor, right: labelsContainer.rightAnchor, topConstant: 5, leftConstant: 15, rightConstant: 15)
        
        labelsContainer.addSubview(categoryLabel)
        categoryLabel.anchor(top: titleLabel.bottomAnchor, left: labelsContainer.leftAnchor, bottom: labelsContainer.bottomAnchor, right: labelsContainer.rightAnchor, topConstant: 2, leftConstant: 15, bottomConstant: 5, rightConstant: 15)
        
        addSubview(labelsContainer)
        labelsContainer.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, leftConstant: 0, bottomConstant: 30, rightConstant: 0)
    }
    
    private func addShadow() {
//        shadowView.layer.cornerRadius = 20.0
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize(width: -1, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
