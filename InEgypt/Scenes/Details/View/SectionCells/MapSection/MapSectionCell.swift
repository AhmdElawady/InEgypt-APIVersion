//
//  MapSectionCell.swift
//  InEgypt
//
//  Created by Awady on 12/21/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class MapSectionCell: UICollectionViewCell {
    
    var mapViewController = MapViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configMapView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configMapView() {
        mapViewController.view.layer.cornerRadius = 3
        mapViewController.view.clipsToBounds = true
        addSubview(mapViewController.view)
        mapViewController.view.fillSuperview()
    }
}

