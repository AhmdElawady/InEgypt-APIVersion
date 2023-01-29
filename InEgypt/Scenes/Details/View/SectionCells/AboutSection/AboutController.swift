//
//  AboutController.swift
//  InEgypt
//
//  Created by Awady on 12/25/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    
    let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description".localized
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .blackToWhite
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let btnImage = UIImage(systemName: "xmark")
        let tintedImage = btnImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .appBlue
        button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .blackToWhite
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let descriptionContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1463886371, green: 0.1449673882, blue: 0.147809886, alpha: 0.6)
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(contentView)
        contentView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 40, leftConstant: 10, bottomConstant: 40, rightConstant: 10)
        
        let topStackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [descriptionLabel, UIView(), dismissButton])
            stack.axis = .horizontal
            return stack
        }()
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.addSubview(descriptionContentLabel)
        descriptionContentLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: view.frame.size.width - 40)
        
        let contentStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [topStackView, titleLabel, separatorView, scrollView])
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        contentView.addSubview(contentStack)
        contentStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10)
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
}
