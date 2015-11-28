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
    
    @IBOutlet weak var startLocationButton: UIButton!
    @IBOutlet weak var targetLocationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    let locationManager = CLLocationManager()

    @IBOutlet weak var toiletToggle: SpotOptionButton!
    @IBOutlet weak var nightSpotsToggle: SpotOptionButton!
    @IBOutlet weak var monumentsToggle: SpotOptionButton!
    @IBOutlet weak var structureToggle: SpotOptionButton!
    @IBOutlet weak var convinienceToggle: SpotOptionButton!
    @IBOutlet weak var theatersToggle: SpotOptionButton!
    
    @IBAction func GoToMapView(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! MapViewController

        controller.spots = SpotManager.sharedController.sightseeingSpotRepository.spots
    
        var viaLocations: [CLLocationCoordinate2D] = []
        if let spot = SpotManager.startSpot {
            viaLocations.append(CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude))
        } else {
            viaLocations.append(locationManager.location!.coordinate)
        }
        if let spot = SpotManager.targetSpot {
            viaLocations.append(CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude))
        }
        controller.viaLocations = viaLocations
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 位置情報に関して権限をもらう
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestAlwaysAuthorization()
        }
        
        let header = SearchHeaderView()
        header.setup(CGRectMake(0, UIApplication.sharedApplication().statusBarFrame.height, self.view.bounds.width, 50))
        self.view.addSubview(header)
        
        searchButton.layer.cornerRadius = 60
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationButton.setTitle(SpotManager.startSpot?.name ?? "(現在地)", forState: .Normal)
        targetLocationButton.setTitle(SpotManager.targetSpot?.name ?? "(タップして設定)", forState: .Normal)
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
        controller.completion = {(spot:Spot?) -> Void in
            SpotManager.startSpot = spot
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func SetTargetLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "SpotSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SpotSetViewController
        controller.completion = {(spot:Spot?) -> Void in
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

