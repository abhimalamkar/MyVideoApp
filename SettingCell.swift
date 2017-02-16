//
//  SettingCell.swift
//  MyVideoApp
//
//  Created by Abhijeet Malamkar on 2/15/17.
//  Copyright © 2017 abhijeetmalamkar. All rights reserved.
//

import UIKit


class SettingCell : BaseCell {
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.purple
        }
    }
    
    var setting:Setting? {
        didSet{
           nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
               iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
               iconImageView.tintColor = UIColor.purple
            }
        }
    }

    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
    
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstrainsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstrainsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstrainsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
    }

}
