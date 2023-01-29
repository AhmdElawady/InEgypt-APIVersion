//
//  HorizontallyInOppositeLayout.swift
//  InEgypt
//
//  Created by Awady on 6/22/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class HorizontallyInOppositeLayout: UICollectionViewFlowLayout {
    override open var flipsHorizontallyInOppositeLayoutDirection:Bool {
        return LocalizationManager.shared.getLanguage() == .arabic
    }
}
