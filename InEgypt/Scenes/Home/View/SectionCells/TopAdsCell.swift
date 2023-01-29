//
//  TopAdsCell.swift
//  InEgypt
//
//  Created by Awady on 11/26/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class TopAdsCell: UICollectionViewCell, AdsViewCell {
    
    var adsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let featureLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1).withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    let subFeatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 65 : 35
        label.font = UIFont(name: "futura-CondensedExtraBold", size: fontSize)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
//        adjustDevicesFonts()
        addSubview(adsImageView)
        adsImageView.fillSuperview()
        addTitleLabel()
    }
    
    private func addTitleLabel() {
        let view = UIView()
        view.backgroundColor = .nightViewColor
        let labelsStack = UIStackView(arrangedSubviews: [featureLabel, UIView(), subFeatureLabel])
        labelsStack.spacing = 10
        labelsStack.axis = .vertical
        addSubview(view)
        view.addSubview(labelsStack)
        labelsStack.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, leftConstant: 16, bottomConstant: 25, rightConstant: 16)
        
        view.fillSuperview()
    }
    
    private func adjustDevicesFonts() {
        let deviceType = UIDevice.current.deviceType

        switch deviceType {
        
        case .iPhones_SE_6_7_8:
            subFeatureLabel.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
            
        case .iPhones_X_11_12:
            subFeatureLabel.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
            
        case .iPhones_Plus_Max:
            subFeatureLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
            
        case .iPad:
            subFeatureLabel.font = UIFont.systemFont(ofSize: 70, weight: .heavy)
            
        default:
            print("Unkown device")
            subFeatureLabel.font = UIFont.systemFont(ofSize: 27)
        }
    }
    
    func displaySubfeatureLabel(subFeature: String) {
        subFeatureLabel.text = subFeature
    }
}
