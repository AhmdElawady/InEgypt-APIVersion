//
//  TicketSectionCell.swift
//  InEgypt
//
//  Created by Awady on 12/21/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class TicketSectionCell: UICollectionViewCell, TicketViewCell {
    
    let egyptionsPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        return label
    }()
    
    let studentsPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        return label
    }()
    
    let forignsPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        return label
    }()
    
    let forignStudentsPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .valueTextColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayTicketLabels(ticket: Ticket) {
        let egyptionStack: UIStackView = {
            let titlelabel = UILabel()
            titlelabel.text = "Egyptions: ".localized
            titlelabel.textColor = .blackToWhite
            titlelabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            egyptionsPriceLabel.setContentHuggingPriority(.init(0), for: .horizontal)
            let stack = UIStackView(arrangedSubviews: [titlelabel, egyptionsPriceLabel])
            stack.spacing = 5
            return stack
        }()
        
        let studentStack: UIStackView = {
            let titlelabel = UILabel()
            titlelabel.text = "Students: ".localized
            titlelabel.textColor = .blackToWhite
            titlelabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            studentsPriceLabel.setContentHuggingPriority(.init(0), for: .horizontal)
            let stack = UIStackView(arrangedSubviews: [titlelabel, studentsPriceLabel])
            stack.spacing = 5
            return stack
        }()
        
        let forignStack: UIStackView = {
            let titlelabel = UILabel()
            titlelabel.text = "Forigns: ".localized
            titlelabel.textColor = .blackToWhite
            titlelabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            forignsPriceLabel.setContentHuggingPriority(.init(0), for: .horizontal)
            let stack = UIStackView(arrangedSubviews: [titlelabel, forignsPriceLabel])
            stack.axis = .horizontal
            stack.spacing = 5
            return stack
        }()
        
        let forignStudentStack: UIStackView = {
            let titlelabel = UILabel()
            titlelabel.text = "Forign Students: ".localized
            titlelabel.textColor = .blackToWhite
            titlelabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            forignStudentsPriceLabel.setContentHuggingPriority(.init(0), for: .horizontal)
            let stack = UIStackView(arrangedSubviews: [titlelabel, forignStudentsPriceLabel])
            stack.spacing = 5
            return stack
        }()
        
        let vStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [egyptionStack, studentStack, forignStack, forignStudentStack])
            stack.axis = .vertical
            stack.spacing = 5
            return stack
        }()
        
        addSubview(vStack)
        vStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 16, rightConstant: 16)
        
        
        if ticket.egyptions == nil {
            egyptionStack.isHidden = true
        } else {
            egyptionsPriceLabel.text = "\(ticket.egyptions ?? "") \("EGP".localized)"
        }
        if ticket.students == nil {
            studentStack.isHidden = true
        } else {
            studentsPriceLabel.text = "\(ticket.students ?? "") \("EGP".localized)"
        }
        if ticket.foreign == nil {
            forignStack.isHidden = true
        } else {
            forignsPriceLabel.text =  "\(ticket.foreign ?? "") \("EGP".localized)"
        }
        if ticket.foreignStudents == nil {
            forignStudentStack.isHidden = true
        } else {
            forignStudentsPriceLabel.text = "\(ticket.foreignStudents ?? "") \("EGP".localized)"
        }
    }
}
