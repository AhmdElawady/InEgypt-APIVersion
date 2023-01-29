//
//  CityCell.swift
//  InEgypt
//
//  Created by Awady on 11/27/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell, CitiesViewCell {
    
    let nightView: UIView = {
        let view = UIView()
        view.backgroundColor = .nightViewColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let attractionsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    let spotsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let destinationButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium)
        let image = UIImage(systemName: "location.magnifyingglass")?.imageFlippedForRightToLeftLayoutDirection()
        let tintedImage = image?.withConfiguration(imageConfigration).withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .white.withAlphaComponent(0.80)
        return button
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        adjustDevicesFonts()
        addSubviewsView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviewsView() {
        addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
        
        addSubview(nightView)
//        nightView.fillSuperviewWithRTL()
        nightView.fillSuperview()
        
        let stackView: UIStackView = { // i use stack because label have a delay to adjust RTL aligenment in Arabic lang
            let stack = UIStackView(arrangedSubviews: [titleLabel])
            stack.alignment = .leading
            stack.translatesAutoresizingMaskIntoConstraints = true
            return stack
        }()
        addSubview(stackView)
        stackView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, leftConstant: 5, bottomConstant: 5, rightConstant: 5, heightConstant: 40)
        
        let deviceType = UIDevice.current.deviceSize
        let size: CGFloat = deviceType == .iPad ? 35 : 22
        nightView.addSubview(destinationButton)
        destinationButton.anchor(top: topAnchor, trailing: trailingAnchor, topConstant: 5, rightConstant: 5, widthConstant: size, heightConstant: size)
    }
    
//    private func adjustDevicesFonts() {
//        let deviceType = UIDevice.current.deviceSize
//
//        switch deviceType {
//        case .iPad:
//            titleLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
//            subTitleLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//            attractionsCountLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//            spotsCountLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//
//        default: print("Unkown device")
//        }
//    }
    
    private func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: backgroundImageView)
    }
    
    func configure(data: HomeCity) {
        titleLabel.text = data.title
        displayImage(data: data.poster)
//        attractionsCountLabel.text = "\(data.attractionCount)"
//        spotsCountLabel.text = "\(data.spotCount)"
//        subTitleLabel.text = "\(attractionsCountLabel.text ?? "") \("Attraction".localized)"
    }
    
    func displayCityLabels(city: HomeCity) {
        titleLabel.text = city.title
    }
}
