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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.state == .Normal {
            super.touchesBegan(touches, withEvent: event)
            self.imageView?.image = UIImage(named: "on-" + String(imageId))
        }else{
            super.touchesEnded(touches, withEvent: event)
            self.imageView?.image = UIImage(named: "off-" + String(imageId))
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if touches == nil { return }
        if self.state == .Normal {
            super.touchesBegan(touches!, withEvent: event)
            self.imageView?.image = UIImage(named: "on-" + String(imageId))
        }else{
            super.touchesEnded(touches!, withEvent: event)
            self.imageView?.image = UIImage(named: "off-" + String(imageId))
        }
    }
}