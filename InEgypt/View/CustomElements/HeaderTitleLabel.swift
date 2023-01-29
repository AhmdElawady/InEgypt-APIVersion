//
//  HeaderTitleLabel.swift
//  InEgypt
//
//  Created by Awady on 10/8/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class HeaderTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .blackToWhite
        font = UIFont.boldSystemFont(ofSize: 17)
        textAlignment = .left
    }
}
