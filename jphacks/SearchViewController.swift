//
//  SearchViewController.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation

class SearchViewController: BaseViewController {
    
    var SightseengSpots = [SightseeingSpot]()
    var nightViewSpots = [NightViewSpot]()

    @IBOutlet weak var startLocationButton: UIButton!
    @IBOutlet weak var targetLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    
    @IBAction func GoToMapView(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! MapViewController
        controller.spots = nightViewSpots
        controller.toLocation = CLLocationCoordinate2D(latitude:34.6944022737767, longitude: 135.195888597644)
        controller.fromLocation = CLLocationCoordinate2D(latitude: 34.709759, longitude: 135.248512)

        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestAlwaysAuthorization()
        }
        
        
        let spots = SpotManager.sharedController.toiletSpotRepository.spots
        for spot in spots {
            print(spot.name)
        }
       
        
        let results2 = CSVManager.sightseeingData()
        for result in results2 {
            SightseengSpots.append(SightseeingSpot(result: result))
            print(SightseengSpots.last?.name)
        }
        
        let header = SearchHeaderView()
        header.setup(CGRectMake(0, UIApplication.sharedApplication().statusBarFrame.height, self.view.bounds.width, 50))
        self.view.addSubview(header)
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
        let storyboard = UIStoryboard(name: "SpotSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SpotSetViewController
        controller.completion = {(spot:Spot) -> Void in
            SpotManager.startSpot = spot
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func SetTargetLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "SpotSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SpotSetViewController
        controller.completion = {(spot:Spot) -> Void in
            SpotManager.targetSpot = spot
        }

        self.presentViewController(controller, animated: true, completion: nil)
    }
}


extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch (status) {
        case .NotDetermined:
            print("NotDetermined")
        case .Restricted:
            print("Restricted")
        case .Denied:
            print("Denied")
        case .AuthorizedAlways:
            print("AuthorizedAlways")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest// 取得精度の設定.
            locationManager.distanceFilter = 1// 取得頻度の設定.
            locationManager.startUpdatingLocation()
        case .AuthorizedWhenInUse:
            print("AuthorizedWhenInUse")
        }
    }
    
    // 位置情報がupdateされた時
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(manager.location?.coordinate.latitude),\(manager.location?.coordinate.longitude)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

