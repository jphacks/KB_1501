//
//  SearchedTableViewCell.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import Foundation
import UIKit

class SearchedTableViewCell : UITableViewCell {
    var label: UILabel! = nil
    
    func setup(title: String) {
        self.backgroundColor = UIColor.clearColor()
        if label == nil {
            label = UILabel()
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.blackColor()
            label.backgroundColor = UIColor.whiteColor()
            self.addSubview(label)
        }
        let labelHeight: CGFloat = 40
        let labelWidth: CGFloat = self.bounds.width-50
        label.frame = CGRectMake((self.bounds.width-labelWidth)/2, (self.bounds.height - labelHeight)/2, labelWidth, labelHeight)
        label.text = title
    }
    
}