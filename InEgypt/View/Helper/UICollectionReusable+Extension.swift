//
//  UICollectionReusable+Extension.swift
//  InEgypt
//
//  Created by Awady on 8/21/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

