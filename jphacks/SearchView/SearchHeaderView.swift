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
    var label: UILabel!
    var settingButton: UIButton!
    
    func setup(frame: CGRect){
        self.bounds = frame
        self.frame = frame
        self.backgroundColor = UIColor.colorFromRGB("4caf50", alpha: 1.0)
        
        if label == nil {
            label = UILabel()
            label.textColor = UIColor.whiteColor()
            label.frame = CGRectMake(self.frame.maxX / 2 - 70, self.bounds.minY, 140, self.bounds.height)
            label.text = "@Search"
            label.textAlignment = .Center
            self.addSubview(label)
        }
        
        if settingButton == nil {
            settingButton = UIButton()
            settingButton.backgroundColor = UIColor.grayColor()
            settingButton.frame = CGRectMake(self.frame.maxX  - 70, self.bounds.minY, 50, self.bounds.height)
            settingButton.setTitle("Setting", forState: .Normal)
            self.addSubview(settingButton)
        }
    }
}