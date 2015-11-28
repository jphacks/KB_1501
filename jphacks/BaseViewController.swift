//
//  BaseViewController.swift
//  jphacks
//
//  Created by 山口智生 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    final private var statusBarBackgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.COLOR_BACKGROUND
        statusBarBackgroundView.frame = CGRectMake(0, 0, self.view.bounds.width, Util.getStatusBarHeight())
        statusBarBackgroundView.backgroundColor = Constants.COLOR_DARK_GREEN
        if !self.view.subviews.contains(statusBarBackgroundView) {
            self.view.addSubview(statusBarBackgroundView)
        }
    }
}