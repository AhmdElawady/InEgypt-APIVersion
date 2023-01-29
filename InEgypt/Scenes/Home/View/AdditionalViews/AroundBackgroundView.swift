//
//  AroundBackgroundView.swift
//  InEgypt
//
//  Created by Awady on 9/25/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

//import UIKit
//
//class AroundBackgroundView: UICollectionReusableView {
//
//    private var insetView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "noAround")
//        return imageView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .clear
//        addSubview(insetView)
//
//        insetView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
