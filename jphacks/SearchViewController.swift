//
//  SearchViewController.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import Foundation
import UIKit

class SearchViewController: UIViewController {
    

    @IBOutlet weak var startLocationButton: UIButton!
    @IBOutlet weak var targetLocationButton: UIButton!
    
    
    @IBAction func GoToMapView(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! MapViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  startLocation = Location()
      //  targetLocation = Location()
        /*startLocation.addObserver(self, forKeyPath: "latitude", options: .New, context: nil)
        targetLocation.addObserver(self, forKeyPath: "latitude", options: .New, context: nil)*/
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationButton.setTitle(SpotManager.startLocation.locationName, forState: .Normal)
        targetLocationButton.setTitle(SpotManager.targetLocation.locationName, forState: .Normal)
    }
    
    override func viewWillDisappear(animated: Bool) {
      /*  startLocation.removeObserver(self, forKeyPath: "latitude", context: nil)
        targetLocation.removeObserver(self, forKeyPath: "latitude", context: nil)*/
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SetStartLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "LocationSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! LocationSetViewController
        controller.location = SpotManager.startLocation
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func SetTargetLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "LocationSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! LocationSetViewController
        controller.location = SpotManager.targetLocation
        self.presentViewController(controller, animated: true, completion: nil)
    }
 /*   override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        startLocationButton.setTitle(startLocation.locationName, forState: .Normal)
        targetLocationButton.setTitle(targetLocation.locationName, forState: .Normal)
        
    }*/
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
