//
//  PlacesCell.swift
//  InEgypt
//
//  Created by Awady on 12/5/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class PlacesCell: UICollectionViewCell {
    
    let imageView = DestinationImageView(frame: .zero)
    let weatherLabel = WeatherLabel()
    let titleLabel = DestinationTitleLabel()
    let cityIcon = DestinationSubTitleIcon(frame: .zero)
    let cityLabel = DestinationSubTitleLabel(frame: .zero)
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradiantLayer.frame = self.bounds
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
//            rateStack.widthAnchor.constraint(equalToConstant: 43).isActive = true
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
    
    private func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: imageView)
    }
    
    func configData(data: SectionDestinations) {
        displayImage(data: data.poster)
        titleLabel.text = data.name
        cityLabel.text = data.city
        rateLabel.text = data.rate ?? ""
        
        WeatherService.shared.getTemp(latitude: data.latitude, longitude: data.longitude) { weather, error in
            if error != nil { print("City weather error", error!) }
            DispatchQueue.main.async { [self] in
                let temp = weather?.current?.temp ?? 0
                weatherLabel.text = String(format: temp == floor(temp) ? "%.0f" : "%.1f", temp) + "° C"
            }
        }
    }
}
