//
//  LoacationSetViewController.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import UIKit

class LocationSetViewController: UIViewController {
    
    var location: Location!

    override func viewDidLoad() {
        super.viewDidLoad()
        if location == nil { return }
        location.latitude = 1
        location.longitude = 2
        location.locationName = "sample"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        dismiss()
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}