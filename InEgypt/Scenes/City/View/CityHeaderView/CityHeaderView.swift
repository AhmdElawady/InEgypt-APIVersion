//
//  HeaderView.swift
//  InEgypt
//
//  Created by Awady on 11/20/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func cityIcons(name: String) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        let deviceType = UIDevice.current.deviceSize
        let size: CGFloat = deviceType == .iPad ? 20 : 20
        imageView.image = UIImage(systemName: name)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .medium)
        imageView.anchor(widthConstant: size, heightConstant: size)
        return imageView
    }
}

class CityHeaderView: UICollectionReusableView, CityViewHeader {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subTitleForButtonlabel: UILabel = {
        let label = UILabel()
        label.text = "Get Map".localized
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let residencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let areaIcone = UIImageView().cityIcons(name: "dot.arrowtriangles.up.right.down.left.circle")
    let populationIcone = UIImageView().cityIcons(name: "person.crop.circle")
    let weatherIcone = UIImageView().cityIcons(name: "sun.min.fill")
    let residencyIcone = UIImageView().cityIcons(name: "bed.double.fill")
    
    
    let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    let getAroundButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "InEgyptLogo2")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        let deviceType = UIDevice.current.deviceSize
        let size: CGFloat = deviceType == .iPad ? 90 : 50
        button.anchor(widthConstant: size, heightConstant: size)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    var city: City?
    let gradiantLayer = CAGradientLayer()
    var overAllStacks = UIStackView()
    var tapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addBackgroundImage()
        setupGradiantLayer()
        addContainerView()
        handleStacks()
        addTapOnContainerView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupGradiantLayer() {
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiantLayer.locations = [0, 1]
        
        containerView.layer.addSublayer(gradiantLayer)
        gradiantLayer.frame = self.bounds
    }
    
    private func addBackgroundImage() {
        addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
    }
    
    private func addContainerView() {
        addSubview(containerView)
        containerView.fillSuperview()
    }
    
    private func handleStacks() {
        
        let deviceType = UIDevice.current.deviceSize
        
        let buttonStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [getAroundButton, subTitleForButtonlabel])
            stackView.axis = .vertical
            stackView.spacing = 0
            return stackView
        }()
        
        let firstRowStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleLabel, UIView(), buttonStack])
            let space: CGFloat = deviceType == .iPad ? 30 : 20
            stack.spacing = space
            return stack
        }()
        
        let areaStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [areaIcone, areaLabel])
            let space: CGFloat = deviceType == .iPad ? 15 : 5
            stack.spacing = space
            return stack
        }()
        
        let populationStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [populationIcone, populationLabel])
            let space: CGFloat = deviceType == .iPad ? 15 : 5
            stack.spacing = space
            return stack
        }()
        
        let areaAndPopStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [areaStack, populationStack])
            stack.distribution = .fillEqually
            let space: CGFloat = deviceType == .iPad ? 25 : 10
            stack.spacing = space
            return stack
        }()
        
        let weatherStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [weatherIcone, weatherLabel])
            let space: CGFloat = deviceType == .iPad ? 15 : 5
            stack.spacing = space
            return stack
        }()
        
        let secondRowStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [areaAndPopStack, weatherStack])
            stack.distribution = .fill
            let space: CGFloat = deviceType == .iPad ? 25 : 10
            stack.spacing = space
            return stack
        }()
        
        residencyLabel.numberOfLines = 0
        let residencyStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [residencyIcone, residencyLabel])
            let space: CGFloat = deviceType == .iPad ? 15 : 8
            stack.spacing = space
            return stack
        }()
        
        let botStacksContainer: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [separatorView, secondRowStack, residencyStack])
            secondRowStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
            residencyStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
            separatorView.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
            stack.axis = .vertical
            let space: CGFloat = deviceType == .iPad ? 40 : 20
            stack.spacing = space
            
            return stack
        }()
        
        
        overAllStacks = {
            let stack = UIStackView(arrangedSubviews: [firstRowStack, botStacksContainer])
            firstRowStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
            stack.axis = .vertical
            let space: CGFloat = deviceType == .iPad ? 70 : 40
            stack.spacing = space
            return stack
        }()
        
        containerView.addSubview(overAllStacks)
        overAllStacks.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, leftConstant: 20, bottomConstant: 70, rightConstant: 20)
        adjustDevicesFonts()
    }
    
    private func adjustDevicesFonts() {
        let deviceType = UIDevice.current.deviceSize
        switch deviceType {
        case .iPhone:
            titleLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
            subTitleForButtonlabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
            areaLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            populationLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            weatherLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            residencyLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            
        case .iPad:
            titleLabel.font = UIFont.systemFont(ofSize: 100, weight: .bold)
//            subTitleForButtonlabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
//            areaLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//            populationLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//            weatherLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//            residencyLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
            
        default: print("Unkown device")
        }
    }
    
    private func addTapOnContainerView() {
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        containerView.addGestureRecognizer(tapGesture)
        containerView.isUserInteractionEnabled = true
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        if overAllStacks.isHidden {
            UIView.transition(with: containerView, duration: 0.3, options: .showHideTransitionViews, animations: { [self] in
                gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
                overAllStacks.isHidden = false
            }, completion: nil)
            
        } else {
            UIView.transition(with: containerView, duration: 0.3, options: .showHideTransitionViews, animations: { [self] in
                gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
                overAllStacks.isHidden = true
            }, completion: nil)
        }
    }
    
    private func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: backgroundImageView, givenCellSize: frame.size.width)
    }
    
    func displayInfo(cityInfo: City) {
        titleLabel.text = cityInfo.title
        areaLabel.text = cityInfo.area
        populationLabel.text = cityInfo.population
        residencyLabel.text = cityInfo.residency
    }
    
    func displayTemperature(tempLabel: String) {
        weatherLabel.text = tempLabel
    }
}

// Footer option to solve dynamic height
class FooterView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 35 : 25
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.textColor = .blackToWhite
        label.text = "Overview".localized
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        let deviceType = UIDevice.current.deviceSize
        let fontSize: CGFloat = deviceType == .iPad ? 25 : 15
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        label.textColor = .valueTextColor
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        configureViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configureViews() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, topConstant: 20, leftConstant: 16)
        
        addSubview(overviewLabel)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 10, leftConstant: 16, bottomConstant: 30, rightConstant: 16)
    }
}
