//
//  LoacationSetViewController.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import UIKit



class LocationSetViewController: BaseViewController {
    
    var spot: Spot!
    var completion: (Spot) -> Void = {_ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        if spot == nil { return }
        
        spot = Spot(name: "sample", address: "sample", detail: "", latitude: 1, longitude: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        dismiss()
    }
    
    func dismiss(){
        completion(spot)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}