//
//  ResultsNearbyCell.swift
//  InEgypt
//
//  Created by Awady on 3/26/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class ResultsNearbyCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let distanceIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")
        imageView.anchor(widthConstant: 20, heightConstant: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .subTitleGray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .small)
        return imageView
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func addSubviews() {
        
//        let distanceStack: UIStackView = {
//            let stack = UIStackView(arrangedSubviews: [distanceIcon, distanceLabel])
//            stack.spacing = 2
//            stack.axis = .horizontal
//            return stack
//        }()
        
        let containerStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [imageView, titleLabel])  // distanceStack 
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.spacing = 5
            stack.axis = .vertical
            stack.alignment = .leading
            return stack
        }()
        
        addSubview(containerStack)
        layoutIfNeeded() // To Avoid overlapping imageView above title labels. Appearing after change language
        containerStack.fillSuperview()
    }
    
    private func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: imageView)
    }

    func configData(data: HomeAround) {
        displayImage(data: data.poster)
        titleLabel.text = data.name
//        distanceLabel.text = String(format: "%.2f", data.distance)+" km".localized
    }
}
