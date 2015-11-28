//
//  SpotDetailView.swift
//  jphacks
//
//  Created by 山口智生 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import UIKit

class SpotDetailView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    func setUp(spot: Spot) {
        self.nameLabel.text = spot.name
        self.genreLabel.text = spot.address
        
        self.descriptionView.text = spot.detail
        self.descriptionView.editable = false
    }
}