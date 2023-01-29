//
//  SearchCityCell.swift
//  InEgypt
//
//  Created by Awady on 9/5/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class SearchCityCell: UICollectionViewCell, SearchCitiesViewCell {
    
    let nightView: UIView = {
        let view = UIView()
        view.backgroundColor = .nightViewColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsView()
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviewsView() {
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(nightView)
        nightView.fillSuperview()
        
        addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
    
    func displayCityLabels(city: CityItem) {
        titleLabel.text = city.title
    }
}
