//
//  DestinationCell.swift
//  InEgypt
//
//  Created by Awady on 11/29/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class DestinationCell: UICollectionViewCell, SearchAttractionViewCell {
    
    let imageView = DestinationImageView(frame: .zero)
    let weatherLabel = WeatherLabel()
    let titleLabel = DestinationTitleLabel()
    let cityIcon = DestinationSubTitleIcon(frame: .zero)
    let cityLabel = DestinationSubTitleLabel()
    let rateIcon = DestinationRateicon(frame: .zero)
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    let gradiantLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradiantLayer.frame = self.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupGradient()
        
        addSubview(weatherLabel)
        weatherLabel.anchor(top: topAnchor, trailing: trailingAnchor, topConstant: 5, rightConstant: 5)
        
        let rateStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [rateIcon, rateLabel])
            stack.alignment = .center
            return stack
        }()
        
        let cityStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [cityIcon, cityLabel, UIView()])
            stack.alignment = .leading
            stack.spacing = 1
            return stack
        }()
        
        let cityRateStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [cityStack, UIView(), rateStack])
            stackView.alignment = .leading
            stackView.spacing = 6
            return stackView
        }()
        
        let containerStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, cityRateStack])
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        addSubview(containerStack)
        containerStack.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, leftConstant: 8, bottomConstant: 8, rightConstant: 8)
        
        rateStack.isHidden = true
    }
    
    private func setupGradient() {
        gradiantLayer.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4517021937).cgColor]
        gradiantLayer.locations = [0.7, 1]
        layer.addSublayer(gradiantLayer)
    }
    
    func displayAttraction(attraction: Destination) {
        titleLabel.text = attraction.name
        cityLabel.text = attraction.city
    }
    
    func displayTemperature(tempLabel: String) {
        weatherLabel.text = tempLabel
    }
}
