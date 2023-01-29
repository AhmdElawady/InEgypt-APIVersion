//
//  ImageZoomingCell.swift
//  InEgypt
//
//  Created by Awady on 10/1/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class ImageZoomingCell: UICollectionViewCell, UIScrollViewDelegate {

    var imageScrollView = ImageScrollView()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageScrollView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageScrollView() {
        imageScrollView = ImageScrollView(frame: bounds)
        imageScrollView.delegate = self

        addSubview(imageScrollView)
        imageScrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5)

        imageScrollView.imageView = imageView
        imageScrollView.maximumZoomScale = 3.0
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: imageView, givenCellSize: frame.size.width)
    }
}
