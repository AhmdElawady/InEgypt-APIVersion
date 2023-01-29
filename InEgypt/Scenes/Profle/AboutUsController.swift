//
//  AboutUsController.swift
//  InEgypt
//
//  Created by Awady on 8/3/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class AboutUsController: UITableViewController {
    let images: [UIImage] = []
    let content: [String] = [
        "".localized,
        "".localized,
        "".localized,
        "".localized,
        "".localized
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        toggleTitleImage()
        tableView.backgroundColor = .backgroundColor
        tableView.register(AboutInEgyptInfoCell.self, forCellReuseIdentifier: "AboutInEgyptInfoCell")
    }

    
    private func toggleTitleImage() {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        var imageName = ""
        userInterfaceStyle == .dark ? (imageName = "LogoDark") : (imageName = "LogoLight")
        let imageView = UIImageView(image: UIImage(named: imageName))
        
        imageView.anchor(widthConstant: 55)
        navigationItem.titleView = imageView
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        toggleTitleImage()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutInEgyptInfoCell", for: indexPath) as? AboutInEgyptInfoCell else { return UITableViewCell() }
        cell.backgroundimageView.image = images[indexPath.row]
        cell.contentLabel.text = content[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = images[indexPath.row]
        let imageCrop = currentImage.getCropRatio()
        return tableView.frame.width / imageCrop
    }
    
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}

class AboutInEgyptInfoCell: UITableViewCell {
    
    let backgroundimageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 22)
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backgroundColor
        
        addSubview(backgroundimageView)
        backgroundimageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0)
        
        addSubview(contentLabel)
        contentLabel.anchor(top: backgroundimageView.topAnchor, leading: backgroundimageView.leadingAnchor, trailing: backgroundimageView.trailingAnchor, topConstant: 20, leftConstant: 20, rightConstant: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
