//
//  FeaturedCell.swift
//  InEgypt
//
//  Created by Awady on 8/20/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell, FeatureViewCell {
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let featureLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 0.7515521523)
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 85 : 45
        label.font = UIFont(name: "futura-CondensedExtraBold", size: fontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        clipsToBounds = true
        addSubViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addSubViews() {
        addSubview(imageView)
        imageView.fillSuperview()
        addSubview(featureLabel)
        featureLabel.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, leftConstant: 16, bottomConstant: 25, rightConstant: 16)
    }
    
//   private func displayImage(data: String) {
//        ImageService.downloadImage(withData: data, imageView: imageView)
//    }

//    func configData(data: Ads) {
//        displayImage(data: data.poster)
//        featureLabel.text = data.content
//    }
    
    func displayFeatureCell(subFeature: Ads) {
        featureLabel.text = subFeature.content
    }
}
