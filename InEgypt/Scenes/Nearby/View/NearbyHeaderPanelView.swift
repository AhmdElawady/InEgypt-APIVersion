//
//  NearbyHeaderPanelView.swift
//  InEgypt
//
//  Created by Awady on 10/10/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

class NearbyHeaderPanelView: UICollectionReusableView {
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let radiusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTitleGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let slider = CustomSlider()
    var sliderCallback: ((Float) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubViews()
        setupSlider()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func addSubViews() {

        let resultStackView: UIStackView = {
            let titleLabel = UILabel()
            titleLabel.text = "RESULTS".localized
            titleLabel.textColor = .subTitleGray
            titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            
            let stackView = UIStackView(arrangedSubviews: [titleLabel, resultLabel])
            stackView.axis = .horizontal
            stackView.spacing = 3
            return stackView
        }()
        
        let raduisStackView: UIStackView = {
            let titleLabel = UILabel()
            titleLabel.text = "RADIUS".localized
            titleLabel.textColor = .subTitleGray
            titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            
            let stackView = UIStackView(arrangedSubviews: [titleLabel, radiusLabel])
            stackView.axis = .horizontal
            stackView.spacing = 3
            return stackView
        }()
        
        let labelsStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [raduisStackView, UIView(), resultStackView])
            stackView.spacing = 5
            return stackView
        }()

        addSubview(labelsStack)
        labelsStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, topConstant: 20, leftConstant: 10, rightConstant: 10)
        
        addSubview(slider)
        slider.anchor(top: labelsStack.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topConstant: 15, leftConstant: 10, rightConstant: 10)
    }
    
    private func setupSlider() {
        let value = UserDefaults.standard.float(forKey: "SliderValue")
        slider.value = value
        radiusLabel.text = String(format:"%.1f", slider.value)+" km".localized
        slider.addTarget(self, action: #selector(sliderMoved(slider:event:)), for: .valueChanged)
    }
    
    @objc private func sliderMoved(slider: UISlider, event: UIEvent) {
        let defaults = UserDefaults.standard
        let value = slider.value
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .moved: radiusLabel.text = String(format:"%.1f", value)+" km".localized
            case .ended:
                defaults.set(value, forKey: "SliderValue")
                sliderCallback?(value)
            default:
                break
            }
        }
    }
    
}
