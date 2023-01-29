//
//  DestinationsCell.swift
//  InEgypt
//
//  Created by Awady on 11/26/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class DestinationsCell: UICollectionViewCell, HiddenGemsViewCell, CategoryViewCell {
    
    let imageView = DestinationImageView(frame: .zero)
    let titleLabel = DestinationTitleLabel()
    let cityLabel = DestinationSubTitleLabel()
    let cityIcon = DestinationSubTitleIcon(frame: .zero)
    let weatherLabel = WeatherLabel()
    
    let gradiantLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        weatherLabel.font = UIFont.systemFont(ofSize: 13)
        backgroundColor = .clear
        clipsToBounds = true
        configureView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradiantLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    private func configureView() {
        addSubViews()
        addWeatherLabel()
    }
    
    private func addSubViews() {
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupGradient()
        
        let cityStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [cityIcon, cityLabel, UIView()])
            stack.alignment = .leading
            stack.spacing = 1
            return stack
        }()
        
        let containerStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, cityStack])
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        addSubview(containerStack)
        containerStack.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, leftConstant: 8, bottomConstant: 8, rightConstant: 8)
        
    }
    
    private func setupGradient() {
        gradiantLayer.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4517021937).cgColor]
        gradiantLayer.locations = [0.55, 1]
        layer.addSublayer(gradiantLayer)
    }
    
    private func addWeatherLabel() {
        addSubview(weatherLabel)
        weatherLabel.anchor(top: topAnchor, right: rightAnchor, topConstant: 10, rightConstant: 10)
    }
    
    func displayRecommended(attraction: Recommended) {
        titleLabel.text = attraction.title
        cityLabel.text = attraction.city
    }
    
    func displayByCategory(attraction: SectionDestinations) {
        titleLabel.text = attraction.name
        cityLabel.text = attraction.city
    }
    
    func displayTemperature(tempLabel: String) {
        weatherLabel.text = tempLabel
    }
}
