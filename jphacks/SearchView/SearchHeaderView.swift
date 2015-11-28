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
        self.backgroundColor = UIColor.greenColor()
    }
}