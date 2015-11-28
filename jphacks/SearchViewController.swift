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
        
        // Do any additional setup after loading the view.
        /*let results1 = CSVManager.nightViewData()
        var nightViewSpots = [NightViewSpot]()
        for result in results1 {
            nightViewSpots.append(NightViewSpot(result: result))
            print(nightViewSpots.last?.name)
        }

        
        let results2 = CSVManager.sightseeingData()
        var SightseengSpots = [SightseeingSpot]()
        for result in results2 {
            SightseengSpots.append(SightseeingSpot(result: result))
            print(SightseengSpots.last?.name)
        }*/
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationButton.setTitle(SpotManager.startLocation.locationName, forState: .Normal)
        targetLocationButton.setTitle(SpotManager.targetLocation.locationName, forState: .Normal)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}
