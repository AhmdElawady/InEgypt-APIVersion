//
//  CitySpotsCell.swift
//  InEgypt
//
//  Created by Awady on 11/22/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class CitySpotsCell: UICollectionViewCell {
    
    let spotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        let deviceType = UIDevice.current.deviceSize
        let width: CGFloat = deviceType == .iPad ? 120 : 90
        let height: CGFloat = deviceType == .iPad ? 100 : 60
        imageView.anchor(widthConstant: width, heightConstant: height)
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 23 : 17
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 19 : 12
        label.font = .systemFont(ofSize: fontSize, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let rateIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "star.fill")
        let deviceType = UIDevice.current.deviceSize
        let size: CGFloat = deviceType == .iPad ? 35 : 20
        imageView.anchor(widthConstant: size, heightConstant: size)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .appYellow
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .small)
        return imageView
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        label.font = .systemFont(ofSize: fontSize, weight: .regular)
        let size: CGFloat = deviceType == .iPad ? 30 : 25
        label.widthAnchor.constraint(equalToConstant: 25).isActive = true

        return label
    }()
    
    let rateCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
//        let rateAndCategoryStack: UIStackView = {
//            let stack = UIStackView(arrangedSubviews: [categoryLabel, rateIcon, rateLabel, rateCountLabel])
//            stack.spacing = 2
//            stack.axis = .horizontal
//            stack.distribution = .fillProportionally
//            return stack
//        }()
        
        let deviceType = UIDevice.current.deviceSize
        let labelsStackSpace: CGFloat = deviceType == .iPad ? 15 : 5
        
        let labelsStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleLabel, categoryLabel])
            stack.axis = .vertical
            stack.spacing = labelsStackSpace
            return stack
        }()
        
        let containerStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [spotImageView, labelsStack])
            stack.axis = .horizontal
            stack.spacing = 10
            stack.alignment = .center
            return stack
        }()
        
        addSubview(containerStack)
        containerStack.anchorCenterYToSuperview()
        containerStack.anchor(leading: leadingAnchor, trailing: trailingAnchor, leftConstant: 0, rightConstant: 0)
        
        rateIcon.alpha = 0
        rateLabel.alpha = 0
        rateCountLabel.alpha = 0
    }
    
    func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: spotImageView)
    }
    
    func configureData(data: CityItems) {
        displayImage(data: data.poster)
        titleLabel.text = data.name
        categoryLabel.text = data.category
//        rateLabel.text = data.rate
//        rateCountLabel.text = "\(data.rateCount)"
    }
}
