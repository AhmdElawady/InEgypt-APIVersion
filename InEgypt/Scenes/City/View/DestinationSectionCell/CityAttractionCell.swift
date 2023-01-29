//
//  CityAttractionCell.swift
//  InEgypt
//
//  Created by Awady on 11/22/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class CityAttractionCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 28 : 18
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 22 : 12
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
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
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, rightConstant: 0)
        
        let labelsStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, categoryLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .leading
            stackView.axis = .vertical
            stackView.spacing = 3
            return stackView
        }()
        
        addSubview(labelsStackView)
        layoutIfNeeded()
        labelsStackView.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: imageView)
    }
    
    func configureData(data: CityItems) {
        displayImage(data: data.poster)
        titleLabel.text = data.name
        categoryLabel.text = data.category
    }
}
