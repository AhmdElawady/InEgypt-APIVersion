//
//  SpotMapCell.swift
//  InEgypt
//
//  Created by Awady on 8/26/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

//import UIKit
//
//class SpotMapCell: UICollectionViewCell {
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.textColor = .blackToWhite
//        return label
//    }()
//
//    let categoryLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        label.adjustsFontSizeToFitWidth = true
//        label.textAlignment = .left
//        label.textColor = .subTitleGray
//        return label
//    }()
//
//    var mapViewController = MapViewController()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupViews() {
//
//        let labelsStackView: UIStackView = {
//            let stackView = UIStackView(arrangedSubviews: [titleLabel, categoryLabel, mapViewController.view])
//            stackView.axis = .vertical
//            stackView.alignment = .leading
//            stackView.spacing = 10
//            return stackView
//        }()
//
//        addSubview(labelsStackView)
//        labelsStackView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, leftConstant: 10, rightConstant: 10)
//
//        addSubview(mapViewController.view)
//        mapViewController.view.anchor(top: labelsStackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 20, leftConstant: 10, rightConstant: 10)
//
//        mapViewController.view.layer.cornerRadius = 5
//        mapViewController.view.clipsToBounds = true
//    }
//
//    func configureData(title: String, category: PlaceSection) {
//        titleLabel.text = title
//        categoryLabel.text = category.title
//    }
//}
