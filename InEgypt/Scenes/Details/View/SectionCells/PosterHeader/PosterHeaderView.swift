//
//  PosterCell.swift
//  InEgypt
//
//  Created by Awady on 12/19/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

//class PosterHeaderView: UICollectionReusableView {
//    
//    let posterImageView: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    
//    let kindContainer = UIView()
//    
//    let kindLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 10, weight: .semibold)
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubviews()
//    }
//    
//    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//    
//    private func addSubviews() {
//        
//        kindContainer.addSubview(kindLabel)
//        kindLabel.anchor(top: kindContainer.topAnchor, leading: kindContainer.leadingAnchor, bottom: kindContainer.bottomAnchor, trailing: kindContainer.trailingAnchor, topConstant: 4, leftConstant: 7, bottomConstant: 4, rightConstant: 7)
//        
//        addSubview(posterImageView)
//        posterImageView.fillSuperview()
//        addSubview(kindContainer)
//        kindContainer.anchor(bottom: bottomAnchor, trailing: trailingAnchor, bottomConstant: 2, rightConstant: 2)
//    }
//    
//    func displayImage(data: String) {
//        ImageService.downloadImage(withData: data, imageView: posterImageView)
//    }
//    
//    func configureData(poster: String, type: String) {
//        displayImage(data: poster)
//        if type == "0" {
//            kindContainer.backgroundColor = #colorLiteral(red: 0.7761187553, green: 0.9360051751, blue: 0.8080866933, alpha: 0.7950399032)
//            kindLabel.textColor = #colorLiteral(red: 0.02517149039, green: 0.392229557, blue: 0.0272828266, alpha: 1)
//            kindLabel.text = "ATTRACTION".localized
//        } else if type == "1" {
//            kindContainer.backgroundColor = #colorLiteral(red: 0.6832487918, green: 0.7872420569, blue: 0.9360051751, alpha: 0.7950399032)
//            kindLabel.textColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
//            kindLabel.text = "SPOT".localized
//        }
//    }
//}



class PosterCell: UICollectionViewCell  {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        posterImageView.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func displayImage(data: String) {
//        ImageService.downloadImage(withData: data, imageView: posterImageView)
//    }
}
