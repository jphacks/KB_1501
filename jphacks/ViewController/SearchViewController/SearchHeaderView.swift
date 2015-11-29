//
//  SearchHeaderView.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import Foundation
import UIKit

class SearchHeaderView : UIView {
    var labelImage: UIImageView!
    var settingButton: UIButton!
    
    func setup(frame: CGRect){
        self.bounds = frame
        self.frame = frame
        self.backgroundColor = UIColor.colorFromRGB("4caf50", alpha: 1.0)
        
        if labelImage == nil {
            labelImage = UIImageView()
            labelImage.image = UIImage(named: "logo_search")
            labelImage.frame = CGRectMake(self.frame.maxX / 2 - 70, self.bounds.minY + 6, 140, self.bounds.height - 12)
            labelImage.contentMode = UIViewContentMode.Center
            self.addSubview(labelImage)
        }
        
        if settingButton == nil {
            settingButton = UIButton()
            settingButton.frame = CGRectMake(self.frame.maxX  - 50, self.bounds.minY + 10, self.bounds.height - 16, self.bounds.height - 16)
            settingButton.setBackgroundImage(UIImage(named: "setting"), forState: .Normal)
            settingButton.contentMode = UIViewContentMode.ScaleAspectFill
            //self.addSubview(settingButton)
        }
    }
}