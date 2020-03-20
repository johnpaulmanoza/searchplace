//
//  CityCell.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import SDWebImage

class CityCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var avatarInitialsLabel: UILabel!
    @IBOutlet weak var avatarInitialsView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    public var city: City? {
        didSet {
            guard let item = city else { return }
            // display data
            titleLabel.text = item.cityName
            subTitleLabel.text = item.citySubTitle
            
            if let imageUrl = item.cityBanner {
                avatarInitialsView.isHidden = true
                avatarImageView.sd_setImage(with: URL(string: imageUrl)!)
            } else {
                if let hex = item.cityColor, let initials = item.cityName {
                    avatarInitialsView.isHidden = false
                    avatarInitialsView.backgroundColor = UIColor(hexString: hex)
                    avatarInitialsLabel.text = String(initials.prefix(3))
                } else {
                    avatarImageView.image = nil
                }
            }
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        customize()
    }
    
    private func customize() {
        
        avatarInitialsView.isHidden = true;
        
        avatarInitialsView.clipsToBounds = true; avatarInitialsView.layer.cornerRadius = 25;
        avatarImageView.clipsToBounds = true; avatarImageView.layer.cornerRadius = 25;
    }
}
