//
//  CitiesCell.swift
//  InEgypt
//
//  Created by Awady on 4/18/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CitiesCell: UICollectionViewCell {

    let nightView: UIView = {
        let view = UIView()
        view.backgroundColor = .nightViewColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 50 : 30
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let attractionsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    let spotsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addImageView()
        addLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
    }
    
    func addLabels() {
        addSubview(nightView)
        nightView.fillSuperview()
        
        nightView.addSubview(stackView)
        stackView.anchorCenterSuperview()
    }
    
    private func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: backgroundImageView)
    }
    
    func configure(data: CityItem) {
        titleLabel.text = data.title
        displayImage(data: data.poster)
        attractionsCountLabel.text = "\(data.attCount)"
        spotsCountLabel.text = "\(data.spotCount)"
        subTitleLabel.text = "\(attractionsCountLabel.text ?? "") \("Attractions".localized) | \(spotsCountLabel.text ?? "") \("Spots".localized)"
    }
}
