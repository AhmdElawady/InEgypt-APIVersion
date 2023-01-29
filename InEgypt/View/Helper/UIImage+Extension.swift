//
//  UIImage+Extension.swift
//  InEgypt
//
//  Created by Awady on 10/27/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size:newSize)
        let image = renderer.image { _ in
            draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }
}
