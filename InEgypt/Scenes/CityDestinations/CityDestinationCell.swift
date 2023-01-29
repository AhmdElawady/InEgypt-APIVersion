//
//  CityDestinationCell.swift
//  InEgypt
//
//  Created by Awady on 5/20/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CityDestinationCell: UICollectionViewCell {
    
    let imageView = DestinationImageView(frame: .zero)
    let titleLabel = DestinationTitleLabel()
    let rateIcon = DestinationRateicon(frame: .zero)
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
        
        let rateStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [rateIcon, rateLabel])
            stack.alignment = .center
            return stack
        }()
        
        let containerStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, rateStack])
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        addSubview(containerStack)
        containerStack.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, leftConstant: 8, bottomConstant: 12, rightConstant: 8)
        
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
    
    func configData(data: CityDestination) {
        displayImage(data: data.poster)
        titleLabel.text = data.name
//        rateLabel.text = "9.8"
    }
}
