//
//  GVTableViewCell.swift
//  AirSys
//
//  Created by James Ham on 1/1/17.
//  Copyright © 2017 Dominus Caeli. All rights reserved.
//

import UIKit

class GVTableViewCell: UITableViewCell {
    
    let giftIDLabel = UILabel()
    let giftToLabel = UILabel()
    let giftFromLabel = UILabel()
    let statusLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        giftIDLabel.translatesAutoresizingMaskIntoConstraints = false
        giftToLabel.translatesAutoresizingMaskIntoConstraints = false
        giftFromLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        giftFromLabel.font = UIFont(name: giftFromLabel.font.fontName, size: 12)
        giftToLabel.textAlignment = .left
        giftFromLabel.textAlignment = .left
        statusLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        
        contentView.addSubview(giftIDLabel)
        contentView.addSubview(giftToLabel)
        contentView.addSubview(giftFromLabel)
        contentView.addSubview(statusLabel)
        
        let viewsDict = [
            "ID" : giftIDLabel,
            "giftToLabel" : giftToLabel,
            "giftFromLabel" : giftFromLabel,
            "statusLabel" : statusLabel,
            ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[ID]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[giftToLabel]-2-[giftFromLabel]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[statusLabel]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[ID(50)]-[giftToLabel]-[statusLabel(50)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[ID(50)]-[giftFromLabel]-[statusLabel(50)]-|", options: [], metrics: nil, views: viewsDict))
    }
    
}
