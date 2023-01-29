//
//  GallaryCell.swift
//  InEgypt
//
//  Created by Awady on 12/20/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class GallaryCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: imageView)
    }
}
