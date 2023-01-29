//
//  CustomSlider.swift
//  InEgypt
//
//  Created by Awady on 6/19/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    var trackHeight: CGFloat = 6
    var thumbRadius: CGFloat = 17

    private lazy var thumbView: UIView = {
        let thumb = UIView()
        thumb.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        thumb.layer.borderWidth = 5
        thumb.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1).cgColor
        return thumb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setupSlider() {
        minimumTrackTintColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        maximumTrackTintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        minimumValue = 0
        maximumValue = 30
        isContinuous = true
        translatesAutoresizingMaskIntoConstraints = false
        let thumb = thumbImage(radius: thumbRadius)
        setThumbImage(thumb, for: .normal)
    }
    
    private func thumbImage(radius: CGFloat) -> UIImage {
        thumbView.frame = CGRect(x: 0, y: radius/2, width: radius, height: radius)
        thumbView.layer.cornerRadius = radius/2

        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }
}
