//
//  SearchViewController.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import Foundation
import UIKit

class SearchViewController: BaseViewController {
    
    var SightseengSpots = [SightseeingSpot]()
    var nightViewSpots = [NightViewSpot]()

    @IBOutlet weak var startLocationButton: UIButton!
    @IBOutlet weak var targetLocationButton: UIButton!
    
    
    @IBAction func GoToMapView(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! MapViewController
        controller.spots = nightViewSpots

        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let spots = SpotManager.sharedController.toiletSpotRepository.spots
        for spot in spots {
            print(spot.name)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationButton.setTitle(SpotManager.startSpot.name, forState: .Normal)
        targetLocationButton.setTitle(SpotManager.targetSpot.name, forState: .Normal)
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
        controller.spot = SpotManager.startSpot
        controller.completion = {(spot:Spot) -> Void in
            SpotManager.startSpot = spot
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func SetTargetLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "LocationSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! LocationSetViewController
        controller.spot = SpotManager.targetSpot
        controller.completion = {(spot:Spot) -> Void in
            SpotManager.targetSpot = spot
        }

        self.presentViewController(controller, animated: true, completion: nil)
    }
}
