//
//  StyleGuide.swift
//  InEgypt
//
//  Created by Awady on 10/27/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor {
            switch $0.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
    
    static let appYellow: UIColor = #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.1607843137, alpha: 1)
    static let appLightYellow: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9137254902, blue: 0.8392156863, alpha: 1)
    static let appGreen: UIColor = #colorLiteral(red: 0.5333333333, green: 0.5843137255, blue: 0.4431372549, alpha: 1)
    static let appBlue: UIColor = #colorLiteral(red: 0, green: 0.4210083773, blue: 0.7108312075, alpha: 1)
    static let appPurble: UIColor = #colorLiteral(red: 0.1803921569, green: 0.05490196078, blue: 0.137254902, alpha: 1)
    
//    static let appBlue: UIColor = .systemTeal
    static let nightViewColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1290407698)
    
    static var blackToWhite: UIColor {
        return UIColor.dynamicColor(light: .black, dark: .white)
    }
    static var whiteToBlack: UIColor {
        return UIColor.dynamicColor(light: .white, dark: .black)
    }
    static var subTitleGray: UIColor {
        return UIColor.dynamicColor(light: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), dark: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    }
    static var valueTextColor: UIColor {
        return UIColor.dynamicColor(light: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), dark: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    static var backgroundColor: UIColor {
        return UIColor.dynamicColor(light: #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1), dark: #colorLiteral(red: 0.0862745098, green: 0.09019607843, blue: 0.09803921569, alpha: 1))
    }
    static var iconBackgroundGray: UIColor {
        return UIColor.dynamicColor(light: .white, dark: #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1))
    }
    static var secondBackgroundColor: UIColor {
        return UIColor.dynamicColor(light: #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1), dark: #colorLiteral(red: 0.1450980392, green: 0.1529411765, blue: 0.168627451, alpha: 1))
    }
    
    static var sliderFilledColor: UIColor {
        return UIColor.dynamicColor(light: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), dark: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
    }
    
    static var sliderNonFilledColor: UIColor {
        return UIColor.dynamicColor(light: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), dark: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
    }
}

extension CGFloat {
    static let labelTextSize: CGFloat = 13.0
    static let valueTextSize: CGFloat = 13.0
    static let headerTextSize: CGFloat = 28.0
    static let subHeaderTextSize: CGFloat = 15.0
}

extension UILabel {
  
    func configureHeaderLabel(withText text: String) {
        configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .bold)
    }

    func configureSubHeaderLabel(withText text: String) {
        configure(withText: text, size: .subHeaderTextSize, alignment: .left, lines: 0, weight: .semibold)
    }

    private func configure(withText newText: String,
                         size: CGFloat,
                         alignment: NSTextAlignment,
                         lines: Int,
                         weight: UIFont.Weight) {
        text = newText
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textAlignment = alignment
        numberOfLines = lines
        lineBreakMode = .byTruncatingTail
    }
    
}

extension UIImageView {
    func configureAppIconView(forImage appImage: UIImage, size: CGFloat) {
        image = appImage
        contentMode = .scaleAspectFit
        layer.cornerRadius = size/5.0
        layer.borderColor = UIColor.appBlue.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
    }
}

extension UIButton {
    func roundedActionButton(withText text: String) {
        let bgColor: UIColor = .appBlue
        backgroundColor = bgColor
        setTitle(text, for: UIControl.State.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        layer.cornerRadius = 15
        contentEdgeInsets = UIEdgeInsets(top: 5.5, left: 0, bottom:5.5, right: 0)
    }
}

extension UIStackView {
    func configure(withAxis axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat, distribution: UIStackView.Distribution = .fill) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
    }
}
