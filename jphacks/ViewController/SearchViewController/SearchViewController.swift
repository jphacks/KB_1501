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

    @IBOutlet weak var toiletToggle: SpotOptionButton!
    @IBOutlet weak var nightSpotsToggle: SpotOptionButton!
    @IBOutlet weak var monumentsToggle: SpotOptionButton!
    @IBOutlet weak var structureToggle: SpotOptionButton!
    @IBOutlet weak var convinienceToggle: SpotOptionButton!
    @IBOutlet weak var theatersToggle: SpotOptionButton!

    var splashImageView: UIImageView!

    let locationManager = CLLocationManager()
    

    
    
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
        
        
        let frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width + 100, height: self.view.frame.size.height + 100)
        self.splashImageView = UIImageView(frame: frame)
        self.splashImageView.center = self.view.center
        self.splashImageView.image = UIImage(named: "Loading")
        self.view.addSubview(self.splashImageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationButton.setTitle(SpotManager.startSpot?.name ?? "(現在地)", forState: .Normal)
        targetLocationButton.setTitle(SpotManager.targetSpot?.name ?? "(タップして設定)", forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3,
            delay: 1.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.splashImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.2,
            delay: 1.3,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.splashImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                self.splashImageView.alpha = 0
            }, completion: { (Bool) in
                self.splashImageView.removeFromSuperview()
        })        
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

