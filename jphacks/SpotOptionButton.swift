//
//  SpotOptionButton.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import Foundation
import UIKit

class SpotOptionButton : UIButton {
    
    var imageId: Int = 0
    var tapGestureRecognizer: UITapGestureRecognizer! = nil
    
    private var _selected: Bool = false
    var hilightened: Bool {
        set{
            _selected = newValue
            if newValue {
                print("on" + String(imageId))
                self.setImage(UIImage(named: "on-" + String(imageId)), forState: UIControlState.Normal)
            } else {
                print("off" + String(imageId))
                self.setImage(UIImage(named: "off-" + String(imageId)), forState: UIControlState.Normal)
            }
        }
        get{
            return _selected
        }
    }
    
    func tapped() {
        print("tap")
        hilightened = !hilightened
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
}