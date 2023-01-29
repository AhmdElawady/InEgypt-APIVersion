//
//  StunningDetailsCell.swift
//  InEgypt
//
//  Created by Awady on 11/25/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class StoryDetailsCell: UITableViewCell {
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "Some description descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionSome description erkjgoioih oihiojpoiewjrirj0934jwekfnnv krejngknksnk jnjrnoijqijpjwe fwekl descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionSome description kejrngooij oijoioiqwefowhebv ekjbnrferngovierjger gerkgrneg descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionSome"
        label.numberOfLines = 0
        return label
    }()
    
    let storyImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
//        label.fillSuperview()
        label.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 10, leftConstant: 24, rightConstant: 24)
        addStoryImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addStoryImageView() {
        addSubview(storyImage)
        NSLayoutConstraint.activate([
            storyImage.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            storyImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            storyImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            storyImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            storyImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
