//
//  DetailsCell.swift
//  InEgypt
//
//  Created by Awady on 12/20/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class DetailsSectionCell: UICollectionViewCell, InfoViewCell {
    
    // TopRoundedView Section
    let labelsContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 10
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .blackToWhite
        return label
    }()
    
    let addressIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let image = UIImage(systemName: "location.fill")?.imageFlippedForRightToLeftLayoutDirection()
        imageView.image = image?.withTintColor(.subTitleGray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(widthConstant: 15, heightConstant: 15)
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .subTitleGray
        return label
    }()
    
    let workingHourIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "clock.fill")?.withTintColor(.subTitleGray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(widthConstant: 15, heightConstant: 15)
        return imageView
    }()
    
    let workingHoursLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .subTitleGray
        return label
    }()
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .subTitleGray
        return label
    }()
    
    let toLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .subTitleGray
        return label
    }()
    
    let ticketIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "ticket.fill")?.withTintColor(.subTitleGray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(widthConstant: 15, heightConstant: 15)
        return imageView
    }()
    
    let ticketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .subTitleGray
        return label
    }()
      
    override init(frame: CGRect) {
        super.init(frame: frame)
//        adjustDevicesFonts()
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        let addressStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [addressIcon, addressLabel])
            stackView.spacing = 7
            stackView.alignment = .leading
            return stackView
        }()
        
        let hoursStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [workingHourIcon, workingHoursLabel])
            stackView.alignment = .leading
            stackView.spacing = 7
            return stackView
        }()
        
        let ticketStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [ticketIcon, ticketLabel])
            stackView.alignment = .leading
            stackView.spacing = 7
            return stackView
        }()
        
        let deviceType = UIDevice.current.deviceSize
        let midStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [hoursStack, addressStack, ticketStack])
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = deviceType == .iPad ? 13 : 9
//            stackView.spacing = 9
            return stackView
        }()
        
        let containerStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, midStack])
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = deviceType == .iPad ? 20 : 15
            return stackView
        }()
        
        labelsContainerView.addSubview(containerStack)
        containerStack.anchorCenterYToSuperview()
        containerStack.anchor(leading: labelsContainerView.leadingAnchor, leftConstant: 10)
        
        addSubview(labelsContainerView)
        labelsContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10)
        setupContainerShadow()
    }
    
    private func setupContainerShadow() {
        labelsContainerView.layer.shadowColor = UIColor.systemGray.cgColor
        labelsContainerView.layer.shadowRadius = 5
        labelsContainerView.layer.shadowOpacity = 0.5
        labelsContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
//    func configureCell(data: Info) {
//        titleLabel.text = data.title
//        fromLabel.text = "\(data.from)"
//        toLabel.text = "\(data.to)"
//        workingHoursLabel.text = "\(String(describing: fromLabel.text!)) - \(String(describing: toLabel.text!))"
//        addressLabel.text = data.address
//        if let ticketPrice = data.ticketsPrice?.egyptions {
//            ticketLabel.text = ticketPrice + "EGP".localized
//        } else { ticketLabel.text = "Opened" }
//    }
    
    func displayInfoLabels(info: Info) {
        titleLabel.text = info.title
        fromLabel.text = "\(info.from)"
        toLabel.text = "\(info.to)"
        workingHoursLabel.text = "\(String(describing: fromLabel.text!)) - \(String(describing: toLabel.text!))"
        addressLabel.text = info.address
        if let ticketPrice = info.ticketsPrice?.egyptions {
            ticketLabel.text = ticketPrice + "EGP".localized
        } else { ticketLabel.text = "Unknown" }
    }
}

